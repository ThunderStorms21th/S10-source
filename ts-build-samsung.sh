#!/bin/bash
#
# Kernel Build Script v1.0 by ThunderStorms Team
#

LOG=compile_build.log
RDIR=$(pwd)
export K_VERSION="v2.6"
export K_NAME="ThundeRStormS-Kernel"
export K_BASE="FUE6"
export ANDROID_VERSION=110000
export PLATFORM_VERSION=11
export ANDROID_MAJOR_VERSION=r
export CURRENT_ANDROID_MAJOR_VERSION=r
export BUILD_PLATFORM_VERSION=11
ANDROID=OneUI-R

# export BUILD_CROSS_COMPILE=/home/nalas/kernel/AiO-S10-TS/toolchain/gcc-cfp/gcc-cfp-jopp-only/aarch64-linux-android-4.9/bin/aarch64-linux-android-
# export CROSS_COMPILE=$BUILD_CROSS_COMPILE
OUTDIR=$RDIR/arch/arm64/boot
DTSDIR=$RDIR/arch/arm64/boot/dts/exynos
DTBDIR=$OUTDIR/dtb
DTBTOOL=$RDIR/tools/dtb
DTCTOOL=$RDIR/scripts/dtc/dtc
INCDIR=$RDIR/include
PAGE_SIZE=2048
DTB_PADDING=0

# MAIN PROGRAM
# ------------

MAIN()
{
(
    ## COPY BACK CAMERA FILES FOR OneUI 3.x
	cp -rf /home/nalas/kernel/AiO-S10-TS/builds/camera-oneui3/. /home/nalas/kernel/AiO-S10-TS/drivers/media/platform/exynos/fimc-is2

	START_TIME=`date +%T`
    if [ $MODEL = "G970F" ]; then
    ./build mkimg model=G970F name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "G970N" ]; then
    ./build mkimg model=G970N name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "G973F" ]; then
    ./build mkimg model=G973F name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "G973N" ]; then
    ./build mkimg model=G973N name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "G975F" ]; then
    ./build mkimg model=G975F name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "G975N" ]; then
    ./build mkimg model=G975N name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "G977B" ]; then
    ./build mkimg model=G977B name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "G977N" ]; then
    ./build mkimg model=G977N name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "N970F" ]; then
    ./build mkimg model=N970F name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "N971N" ]; then
    ./build mkimg model=N971N name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "N975F" ]; then
    ./build mkimg model=N975F name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "N976N" ]; then
    ./build mkimg model=N976N name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    elif [ $MODEL = "N976B" ]; then
    ./build mkimg model=N976B name="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION" toolchain=samsung +dtb
    fi

	END_TIME=`date +%T`
	echo "Start compile time is $START_TIME"
	echo "End compile time is $END_TIME"
	echo ""
	echo "Your flasheable release can be found in the builds folder with name :"
	echo "$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION-`date +%Y-%m-%d`.img"
	echo ""
) 2>&1 | tee -a ./$LOG
}

BUILD_FLASHABLES()
{
	cd $RDIR/builds
	mkdir temp2
	cp -rf zip-OneUIR/common/. temp2
    cp -rf *.img temp2/
	cd temp2
	echo ""
	echo "Compressing kernels..."
	tar cv *.img | xz -9 > kernel.tar.xz
	echo "Copying kernels to ts folder..."
	mv kernel.tar.xz ts/
	# mv *.img ts/

    rm -rf *.img	
	zip -9 -r ../$ZIP_NAME *

	cd ..
    rm -rf temp2
}

RUN_PROGRAM()
{
    MAIN
    # BUILD_DTBO
    # BUILD_DTB
    cp -f boot-$MODEL.img builds/$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION.img
    cp -f $MODEL-dtb.img builds/zip-OneUIR/common/ts/dtb/$MODEL-dtb.img
    cp -f $MODEL-dtbo.img builds/zip-OneUIR/common/ts/dtb/$MODEL-dtbo.img
}

RUN_PROGRAM2()
{
    MAIN
    # BUILD_DTBO
    # BUILD_DTB
    cp -f boot-$MODEL.img builds/$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION.img
    cp -f $MODEL-dtb.img builds/zip-OneUIR/common/ts/dtb/$MODEL-dtb.img
    cp -f $MODEL-dtbo.img builds/zip-OneUIR/common/ts/dtb/$MODEL-dtbo.img
}

BUILD_DTBO()
{
python tools/dtbo/mkdtboimg.py create /home/nalas/kernel/AiO-S10-TS/arch/arm64/boot/dts/samsung/dtbo.img /home/nalas/kernel/AiO-S10-TS/arch/arm64/boot/dts/samsung/*.dtbo
}

BUILD_DTB()
{
	echo "Processing dts files."
for dts in $DTSFILES; do
	echo "=> Processing: ${dts}.dts"
	"${CROSS_COMPILE}cpp" -nostdinc -undef -x assembler-with-cpp -I "$INCDIR" "$DTSDIR/${dts}.dts" > "$DTBDIR/${dts}.dts"
	echo "=> Generating: ${dts}.dtb"
	$DTCTOOL -p $DTB_PADDING -i "$DTSDIR" -O dtb -o "$DTBDIR/${dts}.dtb" "$DTBDIR/${dts}.dts"
	# dtc -p $DTB_PADDING -i "$DTSDIR" -O dtb -o "$DTBDIR/${dts}.dtb" "$DTBDIR/${dts}.dts"
done

	echo "Generating dtb.img."
tools/dtbo/mkdtboimg.py create /home/nalas/kernel/AiO-S10-TS/arch/arm64/boot/dtb/exynos9820.img --id=0 --rev=0 --custom1=0xff000000 arch/arm64/boot/dts/exynos/exynos9820.dtb

	echo "Done."
}


# RUN PROGRAM
# -----------

# PROGRAM START
# -------------
clear
echo "*****************************************"
echo "*   ThunderStorms Kernel Build Script   *"
echo "*****************************************"
echo ""
echo "    CUSTOMIZABLE STOCK SAMSUNG KERNEL"
echo "               Samsung S20"
echo "            Build Kernel for"
echo "-----------------------------------------"
echo "|   S10 / N10 family for OneUI Q ROMs   |"
echo "-----------------------------------------"
echo "(1) SM-G970F"
echo "(2) SM-G970N"
echo "(3) SM-G973F/N"
echo "(4) SM-G975F/N"
echo "(5) SM-G977B/N"
echo "(6) SM-N970F"
echo "(7) SM-N971N"
echo "(8) SM-N975F"
echo "(9) SM-N976N"
echo "(10) SM-N976B"
echo "(11) All variants"
echo ""
read -p "Select an option to compile the kernel: " prompt


if [ $prompt = "1" ]; then
    MODEL=G970F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G970F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "2" ]; then
    MODEL=G970N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G973N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "3" ]; then
    MODEL=G973F
    ZIP_DATE=`date +%Y%m%d`
    # ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G973F Selected"
    RUN_PROGRAM
    MODEL=G973N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-F-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G973N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "4" ]; then
    MODEL=G975F
    ZIP_DATE=`date +%Y%m%d`
    # ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G975F Selected"
    RUN_PROGRAM
    MODEL=G975N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-F-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G975N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "5" ]; then
    MODEL=G977B
    ZIP_DATE=`date +%Y%m%d`
    # ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G977B Selected"
    RUN_PROGRAM
    MODEL=G977N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-F-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-G977N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "6" ]; then
    MODEL=N970F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-N970F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "7" ]; then
    MODEL=N971N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-N971N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "8" ]; then
    MODEL=N975F
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-N975F Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "9" ]; then
    MODEL=N976N
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-N976N Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "10" ]; then
    MODEL=N976B
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-$MODEL-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "SM-N976B Selected"
    RUN_PROGRAM
    BUILD_FLASHABLES
elif [ $prompt = "11" ]; then
    ZIP_DATE=`date +%Y%m%d`
    ZIP_NAME=$K_NAME-S10-N10-$ANDROID-$K_VERSION-SAMSUNGS20-$ZIP_DATE.zip
    export KERNEL_VERSION="$K_NAME-$K_BASE-$ANDROID-$MODEL-$K_VERSION"
    echo "All variants Selected"
    MODEL=G970F
    echo "Compiling SM-G970F ..."
    RUN_PROGRAM2
    MODEL=G973F
    echo "Compiling SM-G973F ..."
    RUN_PROGRAM2
    MODEL=G975F
    echo "Compiling SM-G975F ..."
    RUN_PROGRAM2
    MODEL=G975N
    echo "Compiling SM-G975N ..."
    RUN_PROGRAM2
    MODEL=G970N
    echo "Compiling SM-G970N ..."
    RUN_PROGRAM2
    MODEL=G973N
    echo "Compiling SM-G973N ..."
    RUN_PROGRAM2
    MODEL=G977N
    echo "Compiling SM-G977N ..."
    RUN_PROGRAM2
    MODEL=G977B
    echo "Compiling SM-G977B ..."
    RUN_PROGRAM2
    MODEL=N970F
    echo "Compiling SM-N970F ..."
    RUN_PROGRAM2
    MODEL=N975F
    echo "Compiling SM-N975F ..."
    RUN_PROGRAM2
    MODEL=N971N
    echo "Compiling SM-N971N ..."
    RUN_PROGRAM2
    MODEL=N976N
    echo "Compiling SM-N976N ..."
    RUN_PROGRAM2
    MODEL=N976B
    echo "Compiling SM-N976B ..."
    RUN_PROGRAM2
    BUILD_FLASHABLES
fi
