#ifndef __GLAMO_ENGINE_H
#define __GLAMO_ENGINE_H

enum glamo_engine {
	GLAMO_ENGINE_CAPTURE = 0,
	GLAMO_ENGINE_ISP = 1,
	GLAMO_ENGINE_JPEG = 2,
	GLAMO_ENGINE_MPEG_ENC = 3,
	GLAMO_ENGINE_MPEG_DEC = 4,
	GLAMO_ENGINE_LCD = 5,
	GLAMO_ENGINE_CMDQ = 6,
	GLAMO_ENGINE_2D = 7,
	GLAMO_ENGINE_3D = 8,
	GLAMO_ENGINE_MMC = 9,
	GLAMO_ENGINE_MICROP0 = 10,
	GLAMO_ENGINE_RISC = 11,
	GLAMO_ENGINE_MICROP1_MPEG_ENC = 12,
	GLAMO_ENGINE_MICROP1_MPEG_DEC = 13,
#if 0
	GLAMO_ENGINE_H264_DEC = 14,
	GLAMO_ENGINE_RISC1 = 15,
	GLAMO_ENGINE_SPI = 16,
#endif
	__NUM_GLAMO_ENGINES
};

#endif
