/*
 *  $Id$
 *
 *  ADM5120 SoC definitions
 *
 *  This file defines some constants specific to the ADM5120 SoC
 *
 *  Copyright (C) 2007 OpenWrt.org
 *  Copyright (C) 2007 Gabor Juhos <juhosg at openwrt.org>
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License version 2 as published
 *  by the Free Software Foundation.
 *
 */
#ifndef _ADM5120_DEFS_H
#define _ADM5120_DEFS_H

#define ADM5120_SDRAM0_BASE	0x00000000
#define ADM5120_SDRAM1_BASE	0x01000000
#define ADM5120_SRAM1_BASE	0x10000000
#define ADM5120_EXTIO0_BASE	0x10C00000
#define ADM5120_EXTIO0_SIZE	0x00200000
#define ADM5120_EXTIO1_BASE	0x10E00000
#define ADM5120_EXTIO1_SIZE	0x00200000
#define ADM5120_MPMC_BASE	0x11000000
#define ADM5120_MPMC_SIZE	0x00200000
#define ADM5120_USBC_BASE	0x11200000
#define ADM5120_USBC_SIZE	0x00200000
#define ADM5120_PCIMEM_BASE	0x11400000
#define ADM5120_PCIMEM_SIZE	0x00100000
#define ADM5120_PCIIO_BASE	0x11500000
#define ADM5120_PCIIO_SIZE	0x000FFFF0
#define ADM5120_PCICFG_ADDR	0x115FFFF0
#define ADM5120_PCICFG_DATA	0x115FFFF8
#define ADM5120_PCICFG_SIZE	0x00000010
#define ADM5120_SWITCH_BASE	0x12000000
#define ADM5120_SWITCH_SIZE	0x00200000
#define ADM5120_INTC_BASE	0x12200000
#define ADM5120_INTC_SIZE	0x00200000
#define ADM5120_UART0_BASE	0x12600000
#define ADM5120_UART1_BASE	0x12800000
#define ADM5120_UART_SIZE	0x00200000
#define ADM5120_SRAM0_BASE	0x1FC00000

#define ADM5120_NAND_BASE	ADM5120_SRAM1_BASE
#define ADM5120_NAND_SIZE	0xB

#define ADM5120_CLK_175		175000000
#define ADM5120_CLK_200		200000000
#define ADM5120_CLK_225		225000000
#define ADM5120_CLK_250		250000000

#define ADM5120_UART_CLOCK	62500000

#endif /* _ADM5120_DEFS_H */
