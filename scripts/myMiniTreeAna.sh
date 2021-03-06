function RunZJetBalanceMiniTreeAnaWithCustomizedConfig {
    if [ $# -ne 9 ]; then
	echo "give configuration for 'AdditionalWeight', 'LumiCalcFiles', 'PRWFiles' '-inFile' 'pT_binning' 'eta_binning' 'BTagJets' 'BTagOP''-submitDir'"
    else 
	templaceConfigFile=${ROOTCOREBIN}/data/ZJetBalance/ZJetBalanceMiniTree_GenBalanceHistograms.config
	echo "using ${templaceConfigFile} as template"
	tmpConfFileName=__${RANDOM}_tmp.config
	grep -v 'AdditionalWeight' ${templaceConfigFile} | grep -v 'HistPrefix' | grep -v 'LumiCalcFiles' | grep -v 'PRWFiles' | grep -v 'pT_binning' | grep -v 'eta_binning' | grep -v 'BTagJets' | grep -v 'BTagOP' > ${tmpConfFileName}
	echo "AdditionalWeight ${1}" >> ${tmpConfFileName}
	echo "LumiCalcFiles ${2}" >> ${tmpConfFileName}
	echo "PRWFiles ${3}" >> ${tmpConfFileName}
	echo "pT_binning ${4}" >> ${tmpConfFileName}
	echo "eta_binning ${5}" >> ${tmpConfFileName}
	echo "BTagJets ${6}" >> ${tmpConfFileName}
	echo "BTagOP ${7}" >> ${tmpConfFileName}
	
	cat ${tmpConfFileName}
	
	runZJetBalanceMiniTreeAna -inFile ${8} -submitDir ${9} -algorithm 2 -algoConfig ${tmpConfFileName}
	\rm -r ${tmpConfFileName}
    fi
}

  
  


# Z to ee run
# xAOD  : 19890410
# DxAOD : 8782611
# additional weight =  0.44155
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 0.44155 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_e24_lhmedium_L1EM18VH_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root' '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/afs/cern.ch/work/b/btuan/public/output/mcZee/all.root' 'el_hist361106'
rm -f all_el_hist361106.root
hadd all_el_hist361106.root el_hist361106/hist-*.root

# Z to tau tau run
# xAOD  : 19152982
# DxAOD : 438544
# additional weight = 0.0228969
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 0.0228969 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_e24_lhmedium_L1EM18VH_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root' '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/afs/cern.ch/work/b/btuan/public/output/mcZtautau/all.root' 'el_hist361108'
rm -f all_el_hist361108.root
hadd all_el_hist361108.root el_hist361108/hist-*.root

# ttbar run
# xAOD  : 13392604
# DxAOD : 3714174
# additional weight = 0.2773302
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 0.2773302 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_e24_lhmedium_L1EM18VH_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root' '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/afs/cern.ch/work/b/btuan/public/output/mcttbar/all.root' 'el_hist410004' 
rm -f all_el_hist410004.root
hadd all_el_hist410004.root el_hist410004/hist-*.root

# Data
# with dummy input for PRW
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 1.0 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_e24_lhmedium_L1EM18VH_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root' '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/afs/cern.ch/work/b/btuan/public/output/dataZee/all.root' 'el_histData50ns'
rm -f all_el_histData50ns.root
hadd all_el_histData50ns.root el_histData50ns/hist-*.root


# Run Jet Resoponse Fitter
rm -f all_el_MC.root 
hadd all_el_MC.root all_el_hist361106.root all_el_hist361108.root all_el_hist410004.root

ZJetBalancePlotter -usePoisson -inFile all_el_MC.root -outTag allMC_el
ZJetBalancePlotter -usePoisson -inFile all_el_histData50ns.root -outTag allData_el



############################################################
# Z to mumu run
# xAOD  : 19962997
# DxAOD : 9881474
# additional weight = 0.4949895
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 0.4949895 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_mu20_iloose_L1MU15_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root' '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/eos/atlas/user/o/okumura/data/ZBJetBalanceStudy_v20150814/mc15_13TeV_50ns/mc15_13TeV_50ns_361107' 'mu_hist361107'
rm -f all_mu_hist361107.root
hadd all_mu_hist361107.root mu_hist361107/hist-*.root

# Z to tau tau run
# xAOD  : 19152982
# DxAOD : 438544
# additional weight = 0.0228969
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 0.0228969 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_mu20_iloose_L1MU15_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root'  '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/eos/atlas/user/o/okumura/data/ZBJetBalanceStudy_v20150814/mc15_13TeV_50ns/mc15_13TeV_50ns_361108' 'mu_hist361108'
rm -f all_mu_hist361108.root
hadd all_mu_hist361108.root mu_hist361108/hist-*.root

# ttbar run
# xAOD  : 13392604
# DxAOD : 3714174
# additional weight = 0.2773302
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 0.2773302 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_mu20_iloose_L1MU15_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root' '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/eos/atlas/user/o/okumura/data/ZBJetBalanceStudy_v20150814/mc15_13TeV_50ns/mc15_13TeV_50ns_410004' 'mu_hist410004'
rm -f all_mu_hist410004.root
hadd all_mu_hist410004.root mu_hist410004/hist-*.root

# Data
# with dummy input for PRW
RunZJetBalanceMiniTreeAnaWithCustomizedConfig 1.0 '$ROOTCOREBIN/data/ZJetBalance/ilumicalc_histograms_HLT_mu20_iloose_L1MU15_270806-271744.root' '$ROOTCOREBIN/data/ZJetBalance/prw.361106.361107.361108.410004.e3601_a766_a767_r6264.v00_METADATA.root' '20,30,50,75,200' '-2.5,-1.6,-0.8,0.8,1.6,2.5' 'False' 'Fix70' '/eos/atlas/user/o/okumura/data/ZBJetBalanceStudy_v20150814/data15_13TeV_50ns' 'mu_histData50ns'
rm -f all_mu_histData50ns.root
hadd all_mu_histData50ns.root mu_histData50ns/hist-*.root


# Run Jet Resoponse Fitter
rm -f all_mu_MC.root 
hadd all_mu_MC.root all_mu_hist361107.root all_mu_hist361108.root all_mu_hist410004.root

ZJetBalancePlotter -usePoisson -inFile all_mu_MC.root -outTag allMC_mu
ZJetBalancePlotter -usePoisson -inFile all_mu_histData50ns.root -outTag allData_mu


# Run Plotter
testDHGBHOutAndJERFitter | tee constants.tex

#pdflatex table.tex
