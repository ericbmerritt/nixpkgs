# Tease apart EQC zip file from Quviq into
source $stdenv/setup

# Unpack Phase
unzip $src
cd Q*

# Install Phase - beams and docs
outDir=${out}/lib/erlang/lib
echo "Installing beams and includes to $outDir"
docsDir=${docs}/share/doc
echo "Installing docs to $docsDir"
docsBinDir=${docs}/bin
mkdir -p $docsDir
mkdir -p $docsBinDir
for eqclib in *-${version}
do
    # Copy the ebin and include dirs to the erlang lib dir
    outLibDir=${outDir}/${eqclib}
    mkdir -p $outLibDir
    cp -rp $eqclib/{include,ebin} $outLibDir

    # Copy the doc dir to share/doc and generate a helper
    # script to launch them in the default browser
    docsLibDir=${docsDir}/${eqclib}
    cp -rp $eqclib/doc $docsDir/$eqclib

    ## Create helper scripts to open the EQC docs
    ## with the default browser. There should be an xdg-open
    ## dependency on just sunlight.eqc.docs, but cannot work out
    ## how to do that.
    echo "xdg-open ${docsDir}/${eqclib}/index.html" > $docsBinDir/${eqclib%-*}-docs
    chmod +x $docsBinDir/${eqclib%-*}-docs
done

# Install Phase - emacs mode
emacsDir=${emacs}/share/emacs/site-lisp
mkdir -p $emacsDir
cp -rp eqc-${version}/emacs/* $emacsDir

# Install Phase - examples
examplesDir=${examples}/share/eqc-${version}/
mkdir -p $examplesDir
cp -rp eqc-${version}/examples $examplesDir
