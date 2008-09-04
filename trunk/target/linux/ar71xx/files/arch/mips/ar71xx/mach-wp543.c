/*
 *  Compex WP543 board support
 *
 *  Copyright (C) 2008 Gabor Juhos <juhosg@openwrt.org>
 *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License version 2 as published
 *  by the Free Software Foundation.
 */

#include <linux/platform_device.h>
#include <linux/spi/spi.h>
#include <linux/spi/flash.h>
#include <linux/leds.h>

#include <asm/mips_machine.h>
#include <asm/mach-ar71xx/ar71xx.h>
#include <asm/mach-ar71xx/pci.h>
#include <asm/mach-ar71xx/platform.h>

#define WP543_GPIO_LED_1	3
#define WP543_GPIO_LED_2	4
#define WP543_GPIO_LED_WLAN	5
#define WP543_GPIO_LED_CONN	6
#define WP543_GPIO_LED_DIAG	7

static struct flash_platform_data wp543_flash_data = {
	/* TODO: add partition map */
};

static struct spi_board_info wp543_spi_info[] = {
	{
		.bus_num	= 0,
		.chip_select	= 0,
		.max_speed_hz	= 25000000,
		.modalias	= "m25p80",
		.platform_data	= &wp543_flash_data,
	}
};

static struct ar71xx_pci_irq wp543_pci_irqs[] __initdata = {
	{
		.slot	= 1,
		.pin	= 1,
		.irq	= AR71XX_PCI_IRQ_DEV0,
	}, {
		.slot	= 1,
		.pin	= 2,
		.irq	= AR71XX_PCI_IRQ_DEV1,
	}
};

static struct gpio_led wp543_leds_gpio[] = {
	{
		.name		= "wp543:green:led1",
		.gpio		= WP543_GPIO_LED_1,
		.active_low	= 1,
	}, {
		.name		= "wp543:green:led2",
		.gpio		= WP543_GPIO_LED_2,
		.active_low	= 1,
	}, {
		.name		= "wp543:green:wlan",
		.gpio		= WP543_GPIO_LED_WLAN,
		.active_low	= 1,
	}, {
		.name		= "wp543:green:conn",
		.gpio		= WP543_GPIO_LED_CONN,
		.active_low	= 1,
	}, {
		.name		= "wp543:green:diag",
		.gpio		= WP543_GPIO_LED_DIAG,
		.active_low	= 1,
	}
};

static struct gpio_led_platform_data wp543_leds_gpio_data = {
	.leds		= wp543_leds_gpio,
	.num_leds	= ARRAY_SIZE(wp543_leds_gpio),
};

static struct platform_device wp543_leds_gpio_device = {
	.name	= "leds-gpio",
	.id	= -1,
	.dev = {
		.platform_data = &wp543_leds_gpio_data,
	}
};

static void __init wp543_setup(void)
{
	ar71xx_add_device_spi(NULL, wp543_spi_info, ARRAY_SIZE(wp543_spi_info));

	ar71xx_add_device_mdio(0xfffffff7);
	ar71xx_add_device_eth(0, PHY_INTERFACE_MODE_MII, 0x00000008);

	ar71xx_add_device_usb();

	ar71xx_pci_init(ARRAY_SIZE(wp543_pci_irqs), wp543_pci_irqs);

	platform_device_register(&wp543_leds_gpio_device);
}

MIPS_MACHINE(MACH_AR71XX_WP543, "Compex WP543", wp543_setup);
