# Clone MamaDroid
git clone https://bitbucket.org/gianluca_students/mamadroid_code.git mamadroid
# Get some malware to look at
git clone https://github.com/ashishb/android-malware.git malware
# Base dir variable for convenience
basedir=$(echo $(pwd)/mamadroid)
cd mamadroid
mv soot_jars soot
cd soot
# axml-2.0.jar
wget https://github.com/secure-software-engineering/soot-infoflow-android/raw/develop/lib/axml-2.0.jar
# slf4j-api-1.7.5.jar
wget https://github.com/secure-software-engineering/soot-infoflow-android/raw/b436c512431d875a0bb3c53ea55bbdb137c0aab0/lib/slf4j-api-1.7.5.jar
# slf4j-simple-1.7.5.jar
wget https://github.com/secure-software-engineering/soot-infoflow-android/raw/b436c512431d875a0bb3c53ea55bbdb137c0aab0/lib/slf4j-simple-1.7.5.jar
# soot-infoflow-android.jar should already be in there
# soot-infoflow.jar should already be in there
# soot-trunk.jar should already be in there
# SourcesAndSinks.txt

cd ..

wget https://raw.githubusercontent.com/secure-software-engineering/soot-infoflow-android/develop/SourcesAndSinks.txt
# AndroidCallbacks.txt
wget https://raw.githubusercontent.com/0-14N/soot-infoflow-android/master/AndroidCallbacks.txt

cd ./soot

# EasyTaintWrapperSource.txt
wget https://raw.githubusercontent.com/secure-software-engineering/soot-infoflow/develop/EasyTaintWrapperSource.txt
# Export classpath for java
export CLASSPATH="$basedir/.:$basedir/soot/soot-trunk.jar:$basedir/soot/soot-infoflow.jar:$basedir/soot/soot-infoflow-android.jar:$basedir/soot/slf4j-simple-1.7.5.jar:$basedir/soot/slf4j-api-1.7.5.jar:$basedir/soot/axml-2.0.jar:$basedir/soot/sootclasses-trunk-jar-with-dependencies.jar"
cd ..
# Compile Appgraph
javac -cp $CLASSPATH Appgraph.java
export ANDROID_JARS=$ANDROID_SDK_ROOT/platforms
# Get DroidBench
cd ..
git clone https://github.com/secure-software-engineering/DroidBench.git
cd mamadroid
# Add DroidBench path
export DROIDBENCH=$HOME/DroidBench
# Now we try it on an app
badapp=../android-malware/Android.Malware.at_plapk.a/com.fdhgkjhrtjkjbx.model.apk
python2 mamadroid.py -f $badapp -d $ANDROID_JARS
# A ton of stuff gets output
less com.fdhgkjhrtjkjbx.model.txt
# ^^ Presumably this file is what I will be able to do something interesting with using MaMaDroid once I learn how it works
