#!/bin/bash
#
# ThundeRStorms cleaning script v1.0

make mrproper
rm -f compile_build.log
rm -f builds/*.img
rm -f *.img
rm -f arch/arm64/boot/dts/exynos/*.dtb
rm -f arch/arm64/boot/dts/exynos/*.dtbo
rm -f arch/arm64/boot/dts/samsung/*.dtbo
rm -f arch/arm64/boot/dts/samsung/*.dtbo.reverse.dts
rm -f arch/arm64/boot/dts/exynos/*.img
rm -f arch/arm64/boot/dts/samsung/*.img
