library(clonevol)

setwd("/Users/chronia/CHOP/GitHub/pbta-tumor-evolution/analyses/tumor-clone-inference/plots/clusters3_driver_genes1")
getwd()

#clonevol_input_file <- file.path(results_dir, "clonevol-input", "clonevol_input.tsv") 

#x <- readr::read_tsv(clonevol_input_file, guess_max = 100000, show_col_types = FALSE)
  
#x <- clonevol_input_df_goi
x <- clonevol_input_df
#head(aml1$variants)

# preparation
# shorten vaf column names as they will be
vaf.col.names <- grep('.vaf', colnames(x), value=TRUE)
sample.names <- gsub('.vaf', '', vaf.col.names)
x[, sample.names] <- x[, vaf.col.names]
vaf.col.names <- sample.names

# Order names
#vaf.col.names <- sort(vaf.col.names, decreasing = FALSE)
#vaf.col.names <- sort(vaf.col.names)
print(vaf.col.names)

# prepare sample grouping
sample.groups <- c('Dx', 'R', "Dec");
names(sample.groups) <- vaf.col.names
print(sample.groups)

# setup the order of clusters to display in various plots (later)
x <- x[order(x$cluster),]


####################################################################################################
# Define colors
palette_file <- file.path(root_dir, "figures", "palettes", "tumor_descriptor_color_palette.tsv")
# Read color palette
palette_df <- readr::read_tsv(palette_file, guess_max = 100000, show_col_types = FALSE) %>% 
  filter(color_names %in% c("Deceased", "Diagnosis", "Recurrence")) #%>% 
  
  # Add color for the founder clone needed for `infer.clonal.models` function, if polyclonal model is used
  # polyclonal model need another color for clone 0
  # https://github.com/hdng/clonevol/issues/49
#  add_row(color_names = "0", hex_codes = "#f8e356")

# Define and order palette
clone.colors <- palette_df$hex_codes
names(clone.colors) <- palette_df$color_names
#clone.colors <- c('#1e90ff', '#800080', '#cd2626')

#clone.colors <- NULL
####################################################################################################

# Visualizations
pdf('box.pdf', width = 8, height = 12, useDingbats = FALSE, title='')
pp <- plot.variant.clusters(x,
                            cluster.col.name = 'cluster',
                            show.cluster.size = FALSE,
                            cluster.size.text.color = 'blue',
                            vaf.col.names = vaf.col.names,
                            vaf.limits = 70,
                            sample.title.size = 20,
                            violin = FALSE,
                            box = FALSE,
                            jitter = TRUE,
                            jitter.shape = 1,
                            jitter.color = clone.colors,
                            jitter.size = 3,
                            jitter.alpha = 1,
                            jitter.center.method = 'median',
                            jitter.center.size = 1,
                            jitter.center.color = 'darkgray',
                            jitter.center.display.value = 'none',
                            highlight = 'is.driver',
                            highlight.shape = 21,
                            highlight.color = 'blue',
                            highlight.fill.color = 'green',
                            highlight.note.col.name = 'gene',
                            highlight.note.size = 2,
                            order.by.total.vaf = FALSE)
dev.off()


# plot clusters pairwise-ly
plot.pairwise(x, col.names = vaf.col.names,
              out.prefix = 'variants.pairwise.plot',
              colors = clone.colors)

# plot mean/median of clusters across samples (cluster flow)
pdf('flow.pdf', width=5, height=5, useDingbats=FALSE, title='')
plot.cluster.flow(x, vaf.col.names = vaf.col.names,
                  sample.names = sample.groups,
                  colors = clone.colors)
dev.off()

clone.colors <- c('grey', '#1e90ff', '#800080', '#cd2626')

# infer consensus clonal evolution trees
y = infer.clonal.models(variants = x,
                        cluster.col.name = 'cluster',
                        vaf.col.names = vaf.col.names,
                        sample.groups = sample.groups,
                        cancer.initiation.model='polyclonal', # 'monoclonal' by default
                        subclonal.test = 'bootstrap',
                        subclonal.test.model = 'non-parametric',
                        num.boots = 1000,
                        founding.cluster = 1,
                        cluster.center = 'mean',
                        ignore.clusters = NULL,
                        clone.colors = clone.colors,
                        min.cluster.vaf = 0.01,
                        # min probability that CCF(clone) is non-negative
                        sum.p = 0.05,
                        # alpha level in confidence interval estimate for CCF(clone)
                        alpha = 0.05)

# map driver events onto the trees
y <- transfer.events.to.consensus.trees(y,
                                        x[x$is.driver,],
                                        #x,
                                        cluster.col.name = 'cluster',
                                        event.col.name = 'gene')


# prepare branch-based trees
y <- convert.consensus.tree.clone.to.branch(y, branch.scale = 'sqrt')



# plot variant clusters, bell plots, cell populations, and trees
plot.clonal.models(y,
                   # box plot parameters
                   box.plot = TRUE,
                   fancy.boxplot = TRUE,
                   fancy.variant.boxplot.highlight = 'is.driver',
                   fancy.variant.boxplot.highlight.shape = 21,
                   fancy.variant.boxplot.highlight.fill.color = 'red',
                   fancy.variant.boxplot.highlight.color = 'black',
                   fancy.variant.boxplot.highlight.note.col.name = 'gene',
                   fancy.variant.boxplot.highlight.note.color = 'blue',
                   fancy.variant.boxplot.highlight.note.size = 2,
                   fancy.variant.boxplot.jitter.alpha = 1,
                   fancy.variant.boxplot.jitter.center.color = 'grey50',
                   fancy.variant.boxplot.base_size = 12,
                   fancy.variant.boxplot.plot.margin = 1,
                   fancy.variant.boxplot.vaf.suffix = '.VAF',
                   # bell plot parameters
                   clone.shape = 'bell',
                   bell.event = TRUE,
                   bell.event.label.color = 'blue',
                   bell.event.label.angle = 60,
                   clone.time.step.scale = 1,
                   bell.curve.step = 2,
                   # node-based consensus tree parameters
                   merged.tree.plot = TRUE,
                   tree.node.label.split.character = NULL,
                   tree.node.shape = 'circle',
                   tree.node.size = 30,
                   tree.node.text.size = 0.5,
                   merged.tree.node.size.scale = 1.25,
                   merged.tree.node.text.size.scale = 2.5,
                   merged.tree.cell.frac.ci = FALSE,
                   # branch-based consensus tree parameters
                   merged.tree.clone.as.branch = TRUE,
                   mtcab.event.sep.char = ',',
                   mtcab.branch.text.size = 1,
                   mtcab.branch.width = 0.75,
                   mtcab.node.size = 3,
                   mtcab.node.label.size = 1,
                   mtcab.node.text.size = 1.5,
                   # cellular population parameters
                   cell.plot = TRUE,
                   num.cells = 100,
                   cell.border.size = 0.25,
                   cell.border.color = 'black',
                   clone.grouping = 'horizontal',
                   #meta-parameters
                   scale.monoclonal.cell.frac = TRUE,
                   show.score = FALSE,
                   cell.frac.ci = TRUE,
                   disable.cell.frac = FALSE,
                   # output figure parameters
                   out.dir = 'output',
                   out.format = 'pdf',
                   overwrite.output = TRUE,
                   width = 8,
                   height = 4,
                   # vector of width scales for each panel from left to right
                   panel.widths = c(3,4,2,4,2))

# plot trees only
pdf('trees.pdf', width = 3, height = 5, useDingbats = FALSE)
plot.all.trees.clone.as.branch(y, branch.width = 0.5,
                               node.size = 1, node.label.size = 0.5)
dev.off()

################################################################################
#Then, you can prepare annotated branch-based tree with branch length scaled to the number of clonal marker variants of the clones
y = convert.consensus.tree.clone.to.branch(y, branch.scale = 'sqrt')

#You can then also map driver events onto the tree (if the variant file you prepared has 'cluster', 'is.driver', and 'gene' column):
  
y <- transfer.events.to.consensus.trees(y,
                                        y$variants[y$variants$is.driver,],
                                        cluster.col.name = 'cluster',
                                        event.col.name = 'gene')

#Now plot the tree with this:
  
pdf('imported-tree.pdf', width=3, height=5, useDingbats=F)
plot.all.trees.clone.as.branch(y, branch.width = 0.5, 
                               node.size = 1, node.label.size = 0.5)
dev.off()


## How to obtain the best visualizations?

plot.clonal.models(y,
                   # box plot parameters
                   box.plot = TRUE,
                   fancy.boxplot = TRUE,
                   #fancy.variant.boxplot.highlight = 'is.driver',
                   fancy.variant.boxplot.highlight.shape = 21,
                   fancy.variant.boxplot.highlight.fill.color = 'red',
                   fancy.variant.boxplot.highlight.color = 'black',
                   fancy.variant.boxplot.highlight.note.col.name = 'gene',
                   fancy.variant.boxplot.highlight.note.color = 'blue',
                   fancy.variant.boxplot.highlight.note.size = 2,
                   fancy.variant.boxplot.jitter.alpha = 1,
                   fancy.variant.boxplot.jitter.center.color = 'grey50',
                   fancy.variant.boxplot.base_size = 12,
                   fancy.variant.boxplot.plot.margin = 1,
                   fancy.variant.boxplot.vaf.suffix = '.VAF',
                   # bell plot parameters
                   clone.shape = 'bell',
                   bell.event = TRUE,
                   bell.event.label.color = 'blue',
                   bell.event.label.angle = 60,
                   clone.time.step.scale = 1,
                   bell.curve.step = 2,
                   # node-based consensus tree parameters
                   merged.tree.plot = TRUE,
                   tree.node.label.split.character = NULL,
                   tree.node.shape = 'circle',
                   tree.node.size = 30,
                   tree.node.text.size = 0.5,
                   merged.tree.node.size.scale = 1.25,
                   merged.tree.node.text.size.scale = 2.5,
                   merged.tree.cell.frac.ci = FALSE,
                   # branch-based consensus tree parameters
                   merged.tree.clone.as.branch = TRUE,
                   mtcab.event.sep.char = ',',
                   mtcab.branch.text.size = 1,
                   mtcab.branch.width = 0.75,
                   mtcab.node.size = 3,
                   mtcab.node.label.size = 1,
                   mtcab.node.text.size = 1.5,
                   # cellular population parameters
                   cell.plot = TRUE,
                   num.cells = 100,
                   cell.border.size = 0.25,
                   cell.border.color = 'black',
                   clone.grouping = 'horizontal',
                   #meta-parameters
                   scale.monoclonal.cell.frac = TRUE,
                   show.score = FALSE,
                   cell.frac.ci = TRUE,
                   disable.cell.frac = FALSE,
                   # output figure parameters
                   out.dir = 'output',
                   out.format = 'pdf',
                   overwrite.output = TRUE,
                   width = 8,
                   height = 4,
                   # vector of width scales for each panel from left to right
                   panel.widths = c(3,4,2,4,2))

############################################################################################################################
# https://github.com/chrisamiller/fishplot
#clonevol integration
#If you have inferred tumor phylogeny via the clonevol package, the resulting models can be easily exported to fishplot using the generateFishplotInputs() function, as follows:

# Useful code for fishplot
# https://gist.github.com/chrisamiller/f4eae5618ec2985e105d05e3032ae674
library(fishplot)
#generate phylogeny with clonevol
#x = infer.clonal.models(variants=v, vaf.col.names=samples, ...)
#create a list of fish objects 
f = generateFishplotInputs(results=y) #results=x
fishes = createFishPlotObjects(f)
#plot with fishplot
pdf('fish.pdf', width=8, height=4)
for (i in 1:length(fishes)){
  fish = layoutClones(fishes[[i]])
  fish = setCol(fish, c("#1e90ff",  "#800080", "#cd2626")) # f$clonevol.clone.colors
  fishPlot(fish,shape="spline", title.btm="Patient", cex.title=0.4,
           vlines=seq(1, length(sample.groups)), vlab=sample.groups, pad.left=0.5)
}
dev <- dev.off()
