############################################################################################################################################# CloneFinder+_v0.1
# https://github.com/SayakaMiura/CloneFinderPlus
############################################################################################################################################
################################################################################################################
# this worked
# https://pages.github.nceas.ucsb.edu/NCEAS/Computing/local_install_python_on_a_server.html
# how to install python on MacOS
brew install python@3.8
cd /Users/chronia/CHOP/software/Python-3.8.0
mkdir ~/.localpython
./configure --prefix=/home/chronia/.localpython
# export PATH="$PATH:/Users/chronia/CHOP/software/Python-3.8.0"
alias python3=/opt/homebrew/bin/python3.8

# all python3.11(!) symlinks were removed from the directory.
brew unlink python3
python3 --version
#Python 3.8.18
python --version
#3.9.6 this lives here: /Users/chronia/.pyenv/versions
cd /Users/chronia/CHOP/software/CloneFinderPlus


#python -m pip install SciPy NumPy Biopython pandas networkx logbook fire pydot
#python3 -m pip install Bio
python3 -m pip install Phylo
python3 -m pip install SciPy NumPy Biopython pandas networkx logbook fire pydot
pip3 install biopython
pip3 install Bio
pip3 install logbook
pip3 install fire

# Run example
# python3 Bootstrap_CloneFinderPlus.py ./Example/ReadCount.txt ./Example/TumorSite.txt 0
python3 Bootstrap_CloneFinderPlus.py ./Example/ReadCount.txt NA 0
python3 Bootstrap_CloneFinderPlus.py ReadCount.txt NA 0



##########################################################################################################################
# ATRT
python3 Bootstrap_CloneFinderPlus.py ./CloneFinder_input/Atypical_Teratoid_Rhabdoid_Tumor_PT_3KM9W8S8.txt NA 0











######################################################################
# HGG
python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_1H2REHT2.txt 










python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_KBFM551M.txt 
python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_MDWPRDBT.txt 
python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_Z4BF2NSB.txt 

# Error message: At least 4 taxa are required #
python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_8GN3TQRM.txt
python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_3CHB9PK5.txt
python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_37B5JRP1.txt
python clonefinder.py snv ./input/HGG/High_grade_glioma_PT_89XRZBSG.txt

######################################################################
# LGG
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_N8W26H19.txt

# Error message: At least 4 taxa are required #
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_02J5CWN5.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_2MZPGZN1.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_2MZPGZN1.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_2FVTD0WR.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_2YT37G8P.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_3GYW6P6P.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_3T3VGWC6.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_62G82T6Q.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_773ZPTEB.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_962TCBVR.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_HHG37M6W.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_HXV713W6.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_KMHGNCNR.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_PFA762TK.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_QJDY4Y9P.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_S2SQJVGK.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_TRZ1N1HQ.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_XZGWKXC5.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_YDFPMXAR.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_YGN06RPZ.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_ZMKMKCFQ.txt


# Bug other
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_2ECVKTTQ.txt
python clonefinder.py snv ./input/LGG/Low_grade_glioma_PT_N4563ERM.txt

######################################################################
# ATRT
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_3KM9W8S8.txt
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_6N825561.txt
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_DVXE38EX.txt

# Error message: At least 4 taxa are required #
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_0WQFCZ6S.txt
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_ESHACWF6.txt
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_HE8FBFNA.txt
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_RJ1TJ2KH.txt
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_VTG1S395.txt
python clonefinder.py snv ./input/ATRT/Atypical_Teratoid_Rhabdoid_Tumor_PT_XTVQB9S4.txt



######################################################################
# DMG
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_19GCSK2S.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_GTHZF21E.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_KTRJ8TFY.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_KZ56XHJT.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_NK8A49X5.txt


# Error message: At least 4 taxa are required #
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_5NS35B66.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_FA2F3HQG.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_JNEV57VK.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_JSFBMK5V.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_MNSEJCDM.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_P571HTNK.txt
python clonefinder.py snv ./input/DMG/Diffuse_midline_glioma_PT_PR4YBBH3.txt


######################################################################
# Other
python clonefinder.py snv ./input/Other/Chordoma_PT_HFQNKP5X.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_99S5BPE3.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_ZZRBX5JT.txt
python clonefinder.py snv ./input/Other/Ewing_sarcoma_PT_HJMP6PH2.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_0DWRY9ZX.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_9S6WMQ92.txt
python clonefinder.py snv ./input/Other/NA_PT_S4YNE17X.txt
python clonefinder.py snv ./input/Other/Neurofibroma_Plexiform_PT_K8ZV7APT.txt
python clonefinder.py snv ./input/Other/NA_PT_XHYBZKCX.txt
python clonefinder.py snv ./input/Other/Neuroblastoma_PT_5ZPPR06P.txt



# Error message: At least 4 taxa are required #
python clonefinder.py snv ./input/Other/Adamantinomatous_Craniopharyngioma_PT_CBTW4E3X.txt
python clonefinder.py snv ./input/Other/Adamantinomatous_Craniopharyngioma_PT_WYXTEG3E.txt
python clonefinder.py snv ./input/Other/Adamantinomatous_Craniopharyngioma_PT_YK7AD0KK.txt
python clonefinder.py snv ./input/Other/Chordoma_PT_75HRTX4S.txt
python clonefinder.py snv ./input/Other/Choroid_plexus_carcinoma_PT_AV0W0V8D.txt
python clonefinder.py snv ./input/Other/CNS_Embryonal_tumor_PT_5CYJ3NZ9.txt
python clonefinder.py snv ./input/Other/CNS_Embryonal_tumor_PT_7HGY5W67.txt
python clonefinder.py snv ./input/Other/CNS_Embryonal_tumor_PT_BRVGRXQY.txt
python clonefinder.py snv ./input/Other/Craniopharyngioma_PT_WWZWD4KC.txt
python clonefinder.py snv ./input/Other/Dysembryoplastic_neuroepithelial_tumor_PT_DFQAH7RS.txt
python clonefinder.py snv ./input/Other/Dysembryoplastic_neuroepithelial_tumor_PT_Y98Q8XKV.txt
python clonefinder.py snv ./input/Other/Embryonal_tumor_with_multilayer_rosettes_PT_00G007DM.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_04V47WFC.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_3R0P995B.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_3VCS1PPF.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_B5DQ8FF0.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_BZCJMEX8.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_C1RDBCVM.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_DNAJYFZT.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_EQX0VT4F.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_JP1FDKN9.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_NJQ26FHN.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_NPETR8RY.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_PAPEQ0T0.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_T4VN7ZRB.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_TP6GS00H.txt
python clonefinder.py snv ./input/Other/Ependymoma_PT_Z4GS3ZQQ.txt
python clonefinder.py snv ./input/Other/Ganglioglioma_PT_1ZAWNGWT.txt
python clonefinder.py snv ./input/Other/Ganglioglioma_PT_W6AWJJK7.txt
python clonefinder.py snv ./input/Other/Glial_neuronal_tumor_PT_PF04R0BH.txt
python clonefinder.py snv ./input/Other/Hemangioblastoma_PT_WP871F5S.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_23NZGSRJ.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_7WYPEC3Q.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_CXT81GRM.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_FN4GEEFR.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_NZ85YSJ1.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_TKWTTRQ7.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_XA98HG1C.txt
python clonefinder.py snv ./input/Other/Meningioma_PT_39H4JN6H.txt
python clonefinder.py snv ./input/Other/Meningioma_PT_7M2PGCBV.txt
python clonefinder.py snv ./input/Other/Meningioma_PT_AQWDQW27.txt
python clonefinder.py snv ./input/Other/Meningioma_PT_QH9H491G.txt
python clonefinder.py snv ./input/Other/NA_PT_25Z2NX27.txt
python clonefinder.py snv ./input/Other/NA_PT_3A2Q62RD.txt
python clonefinder.py snv ./input/Other/NA_PT_QEP13FH4.txt
python clonefinder.py snv ./input/Other/Pilocytic_astrocytoma_PT_3P3HARZ2.txt
python clonefinder.py snv ./input/Other/Rosai_Dorfman_disease_PT_J06X17XH.txt
python clonefinder.py snv ./input/Other/Schwannoma_PT_6S1TFJ3D.txt
python clonefinder.py snv ./input/Other/Schwannoma_PT_CWXSP19D.txt

# Bug other
python clonefinder.py snv ./input/Other/Adamantinomatous_Craniopharyngioma_PT_T2M1338J.txt
python clonefinder.py snv ./input/Other/CNS_Embryonal_tumor_PT_98QMQZY7.txt
python clonefinder.py snv ./input/Other/Malignant_peripheral_nerve_sheath_tumor_PT_9PJR0ZK7.txt
python clonefinder.py snv ./input/Other/Medulloblastoma_PT_82MX6J77.txt
python clonefinder.py snv ./input/Other/Schwannoma_PT_C1HRBJJD.txt

# There are no parsimony informative sites
python clonefinder.py snv ./input/Other/Ependymoma_PT_D6AJHDST.txt

######################################################################




# test



# https://www.easeus.com/computer-instruction/zsh-command-not-found-python.html#Fix3
export PATH="$PATH:/Users/chronia/.pyenv/versions/3.9.6"
# python 3 (v3.8 was tested)
# pyenv install 3.8.0
brew install python@3.8
export PATH="$(brew --prefix)/opt/homebrew/bin/python3.8/libexec/bin:$PATH"
which python3




/Users/chronia/.pyenv/versions



# https://stackoverflow.com/questions/6767283/find-where-python-is-installed-if-it-isnt-default-dir
# where python lives?
python -c "import sys; print(sys.executable)"
# Library/Developer/CommandLineTools/usr/bin/python3
#######################################################

export PATH="$PATH:/opt/homebrew/bin/python3.8"
python3 --version

conda install -c anaconda python=3.8

conda create --name py38 python==3.8 SciPy NumPy Biopython pandas networkx logbook fire pydot

conda create --name mlenv python==3.7.5 pandas numpy

 
~/. zshrc


###################
# https://superuser.com/questions/1164706/how-do-i-make-a-python-file-executable-on-macos-sierra
How to add that folder to your path?
Find your path first

echo $HOME

If you are using bash or zsh you might have something like this

In ~/.bash_profile or ~/.bashrc or ~/.zshrc at the bottom of your file

export PYTHON_UTILS="$HOME/code/python/utils"

export PATH="$PYTHON_UTILS:$PATH"

Consider removing the .py from your file bc it is not needed in this case

Close and open your terminal, which is sourcing your file by its path

And now you should be able to treat your python file similar to a bash command

You don't need to use python3 filename.py to run the file, you can just use filename