/* main.c
 *
 * Copyright 2023 kevidryon2
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include <stdio.h>
#include <sys/mman.h>
#include <stdlib.h>

int main(int argc, char **argv) {
	if (argc<3) {
		printf("Usage: bxint <file> <hex entrypoint>\n");
		return 1;
	}
									
	FILE *fp = fopen(argv[1], "r");
	register char *xf asm("rbx");
	if (!fp) {
		perror("Can't read file");
		return 2;
	}
	#ifdef DEBUG
		printf("Allocating executable pages\n");
	#endif
	
	fseek(fp, 0, SEEK_END);
	
	xf = mmap((void*)strtol(argv[2], NULL, 16), ftell(fp), PROT_EXEC|PROT_WRITE|PROT_READ, MAP_PRIVATE|MAP_FIXED_NOREPLACE, fp->_fileno, 0);
	
	if (!xf) {
		printf("Invalid page\n");
		return 3;
	}
	
	#ifdef DEBUG
		printf("Executing %x\n", xf);
	#endif
	
	__asm__(
		"push %rbx\nret\n"
	);
	
}
