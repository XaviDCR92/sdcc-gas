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
#include "SDCCmem.h"
#include "SDCCsymt.h"
#include "SDCCicode.h"
#include "port.h"
#include "newalloc.h"
#include "dbuf_string.h"
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

static char *set_dst(void);
static FILE *create_file(const char *path);
static void emit_file_name(FILE *f, const char *dst);
static void emit_rodata(FILE *f);
static void print_section(FILE *f, const char *section);
static const char *get_filename(const char *dst);

extern const char *iComments1;
extern const char *iComments2;

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

  fprintf(f, "%s%s", iComments1, iComments2);

  /* Print input file name without extension. */
  emit_file_name(f, fullSrcFileName);

  /* Print read only local variables. */
  emit_rodata(f);

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
      /* No output file name has been designated.
       * Use port default extension, if available. */
      const char *const extension = port->assembler.file_ext ?
                                    port->assembler.file_ext : ".asm";
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

static void emit_rodata(FILE *const f)
{
  if (!statsg)
    return;

  if (!statsg->syms)
    return;

  print_section(f, "rodata");

  {
    struct set *p;

    for (p = statsg->syms; p; p = p->next)
      {
        symbol *const sym = p->item;
        struct sym_link *const etype = sym->etype;

        if (IS_EXTERN(etype) || !sym->ival)
          continue;

        if (SPEC_CONST(etype))
          {
            const char *const name = sym->name;

            /* Declare object. */
            if (SPEC_STAT(etype))
              fprintf(f, "\t.local %s\n", name);
            else
              fprintf(f, "\t.global %s\n", name);

            fprintf(f, "\t.type %s, @object\n", name);

            if (SPEC_STRUCT(etype))
              {
                /* Point to first struct element. */
                struct symbol *field;

                /* Print sizeof struct. */
                fprintf(f, "\t.size %s, %d\n", name, etype->select.s.v_struct->size);
                /* Print instance name as a label. */
                fprintf(f, "%s:\n", name);

                for (field = etype->select.s.v_struct->fields; field; field = field->next)
                  {
                    struct sym_link *ft = field->etype;

                    printf("%s.%s\n", name, field->name);

                    if (SPEC_LONG(ft))
                      {
                        fprintf(f, "\t.long %d\n", ft->select.s.const_val.v_long);
                      }
                    else if (SPEC_SHORT(ft))
                      {
                        fprintf(f, "\t.hword %d\n", ft->select.s.const_val.v_int);
                      }
                  }
              }
          }
      }
  }
}

static void print_section(FILE *const f, const char *const section)
{
  fprintf(f, "\t.section .%s\n", section);
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
