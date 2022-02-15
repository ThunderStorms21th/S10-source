# SPDX-License-Identifier: GPL-2.0
dtb-y += exynos/exynos9825.dtb
dtbo-y += samsung/exynos9825-d1x_kor_single_18.dtbo
dtbo-y += samsung/exynos9825-d1x_kor_single_19.dtbo
dtbo-y += samsung/exynos9825-d1x_kor_single_21.dtbo
dtbo-y += samsung/exynos9825-d1x_kor_single_22.dtbo
dtbo-y += samsung/exynos9825-d1x_kor_single_23.dtbo

targets += dtbs
DTB_LIST  := $(dtb-y) $(dtbo-y)
always    := $(DTB_LIST)

dtbs: $(addprefix $(obj)/, $(DTB_LIST))

clean-files := *.dtb*
