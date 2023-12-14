#' Create fishplot with clone.annots
#'
#' @param results
#' @param clone.annots
#' 
#'
#' @return
#' @export
#'
#' @examples
createFishPlotObjects.clone.annots <- function(results, clone.annots.values){
  
  fishes = list()
  for(i in 1:results$num.models){
    print(i)
    fishes[[i]]=createFishObject(results$cell.fractions[[i]],
                                 parents = as.integer(results$parents[[i]]),
                                 timepoints = results$timepoints,
                                 clone.labels = results$clonevol.clone.names[1:length(results$clonevol.clone.names)],
                                 fix.missing.clones = TRUE,
                                 clone.annots = clone.annots.values,
                                 clone.annots.angle = 60,
                                 clone.annots.col = "black",
                                 clone.annots.pos = 2,
                                 clone.annots.cex = 0.3,
                                 clone.annots.offset = 0.2)
    
    }
  
  return(fishes)
  
  }

  