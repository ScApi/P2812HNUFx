/*
 *  Cellvision/SparkLAN boards
 *
 *  Copyright (C) 2007-2008 Gabor Juhos <juhosg@openwrt.org>
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License version 2 as published
 *  by the Free Software Foundation.
 *
 */

#include "cellvision.h"

#include <prom/admboot.h>

#define CELLVISION_GPIO_FLASH_A20	ADM5120_GPIO_PIN5
#define CELLVISION_GPIO_DEV_MASK	(1 << CELLVISION_GPIO_FLASH_A20)

#define CELLVISION_CONFIG_OFFSET	0x8000
#define CELLVISION_CONFIG_SIZE		0x1000

#ifdef CONFIG_MTD_PARTITIONS
static struct mtd_partition cas6xx_partitions[] = {
	{
		.name	= "admboot",
		.offset	= 0,
		.size	= 32*1024,
		.mask_flags = MTD_WRITEABLE,
	} , {
		.name	= "config",
		.offset	= MTDPART_OFS_APPEND,
		.size	= 32*1024,
	} , {
		.name	= "nvfs1",
		.offset	= MTDPART_OFS_APPEND,
		.size	= 64*1024,
	} , {
		.name	= "nvfs2",
		.offset	= MTDPART_OFS_APPEND,
		.size	= 64*1024,
	} , {
		.name	= "firmware",
		.offset	= MTDPART_OFS_APPEND,
		.size	= MTDPART_SIZ_FULL,
	}
};

static struct mtd_partition cas7xx_partitions[] = {
	{
		.name	= "admboot",
		.offset	= 0,
		.size	= 32*1024,
		.mask_flags = MTD_WRITEABLE,
	} , {
		.name	= "config",
		.offset	= MTDPART_OFS_APPEND,
		.size	= 32*1024,
	} , {
		.name	= "nvfs",
		.offset	= MTDPART_OFS_APPEND,
		.size	= 128*1024,
	} , {
		.name	= "firmware",
		.offset	= MTDPART_OFS_APPEND,
		.size	= MTDPART_SIZ_FULL,
	}
};
#endif /* CONFIG_MTD_PARTITIONS */

static void switch_bank_gpio5(unsigned bank)
{
	switch (bank) {
	case 0:
		gpio_set_value(CELLVISION_GPIO_FLASH_A20, 0);
		break;
	case 1:
		gpio_set_value(CELLVISION_GPIO_FLASH_A20, 1);
		break;
	}
}

static void __init cellvision_flash_setup(void)
{
	/* setup flash A20 line */
	gpio_request(CELLVISION_GPIO_FLASH_A20, NULL);
	gpio_direction_output(CELLVISION_GPIO_FLASH_A20, 0);

	adm5120_flash0_data.switch_bank = switch_bank_gpio5;
	adm5120_add_device_flash(0);
}

void __init cellvision_mac_setup(void)
{
	u8 mac_base[6];
	int err;

	err = admboot_get_mac_base(CELLVISION_CONFIG_OFFSET,
				   CELLVISION_CONFIG_SIZE, mac_base);

	if ((err) || !is_valid_ether_addr(mac_base))
		random_ether_addr(mac_base);

	adm5120_setup_eth_macs(mac_base);
}

void __init cas6xx_flash_setup(void)
{
#ifdef CONFIG_MTD_PARTITIONS
	adm5120_flash0_data.nr_parts = ARRAY_SIZE(cas6xx_partitions);
	adm5120_flash0_data.parts = cas6xx_partitions;
#endif /* CONFIG_MTD_PARTITIONS */

	cellvision_flash_setup();
}

void __init cas7xx_flash_setup(void)
{
#ifdef CONFIG_MTD_PARTITIONS
	adm5120_flash0_data.nr_parts = ARRAY_SIZE(cas7xx_partitions);
	adm5120_flash0_data.parts = cas7xx_partitions;
#endif /* CONFIG_MTD_PARTITIONS */

	cellvision_flash_setup();
}

#if 0
void __init cas6xx_setup(void)
{
	cas6xx_flash_setup();
	adm5120_add_device_switch(1, NULL);
}

ADM5120_BOARD(MACH_ADM5120_CAS630, "Cellvision CAS-630/630W", cas6xx_setup);
ADM5120_BOARD(MACH_ADM5120_CAS670, "Cellvision CAS-670/670W", cas6xx_setup);
#endif

void __init cas7xx_setup(void)
{
	cas7xx_flash_setup();

	cellvision_mac_setup();
	adm5120_add_device_switch(1, NULL);
}

#if 0
ADM5120_BOARD(MACH_ADM5120_CAS700, "Cellvision CAS-700/700W", cas7xx_setup);
ADM5120_BOARD(MACH_ADM5120_CAS790, "Cellvision CAS-790", cas7xx_setup);
ADM5120_BOARD(MACH_ADM5120_CAS861, "Cellvision CAS-861/861W", cas7xx_setup);
#endif
