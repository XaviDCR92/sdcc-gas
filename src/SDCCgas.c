/*-------------------------------------------------------------------------
  SDCCgas.c - source file for GAS (GNU Assembler) file generation

  Copyright (C) 2019, Xavier Del Campo Romero

  This program is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published by the
  Free Software Foundation; either version 2, or (at your option) any
  later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-------------------------------------------------------------------------*/

#include "SDCCgas.h"
#include "SDCCglobl.h"
#include "newalloc.h"
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

static char *set_dst(void);
static FILE *create_file(const char *const path);
static void emit_file_name(FILE *const f, const char *const dst);
static const char *get_filename(const char *const dst);

void gas_glue(void)
{
  int clean_dst = 0;
  const char *dst = fullDstFileName;

  if (!gasOutput)
    {
      werror(W_ILLEGAL_OPT_COMBINATION, __FILE__, __FUNCTION__,
            "this function must only be called if GAS"
            "(GNU Assembler) output has been specified");
      exit(1);
    }

  if (!dst)
    {
      dst = set_dst();
      /* Set reminder flag so memory is free'd. */
      clean_dst = 1;
    }

  FILE *const f = create_file(dst);

  emit_file_name(f, fullSrcFileName);

  if (clean_dst)
    /* dst must not be modified by gas_glue(), but memory
     * cleanup is needed if no output filepath was given. */
    Safe_free((void*)dst);

  fclose(f);
}

static char *set_dst(void)
{
  char *dst = NULL;
  size_t len;

  /* Set default output assembly file. */
  if (!fullSrcFileName)
    {
      werror(E_PARAM_NAME_OMITTED, __FILE__, __FUNCTION__,
            "input filename has not been specified.");
      exit(1);
    }

  /* Calculate file name length. */
  for (len = 0; fullSrcFileName[len] != '.' && fullSrcFileName[len]; len++)
    ;

    {
      /* No output file name has been designated. Use default extension. */
      const char extension[] = ".s";
      const size_t total_len = len + strlen(extension) + 1;

      dst = Safe_calloc(total_len, sizeof *fullDstFileName);

      strncpy(dst, fullSrcFileName, len);
      strcat(dst, extension);
    }

  return dst;
}

static FILE *create_file(const char *const path)
{
  FILE *const f = fopen(path, "wb");

  if (!f)
    {
      werror(E_FILE_OPEN_ERR, __FILE__, __FUNCTION__);
      exit(1);
    }

  return f;
}

static void emit_file_name(FILE *const f, const char *const dst)
{
  /* Get file name without path. */
  const char *filename = get_filename(dst);

  printf("%s\n", filename);

  fprintf(f, "\t.file\t\"%s\"\n", filename);
}

static const char *get_filename(const char *const dst)
{
  const char *p;

  for (p = dst + strlen(dst); *p != '\\' && *p != '/' && (p - dst); p--)
    ;

  if (p == dst)
    /* No directories specified. */
    return dst;
  else
    /* Skip directory separator. */
    return ++p;
}
