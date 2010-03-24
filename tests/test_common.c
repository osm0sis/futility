/* Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 *
 * Common functions used by tests.
 */

#include "test_common.h"

#include <stdio.h>

/* ANSI Color coding sequences. */
#define COL_GREEN "\e[1;32m"
#define COL_RED "\e[0;31m]"
#define COL_STOP "\e[m"

/* Global test success flag. */
int gTestSuccess = 1;

int TEST_EQ(int result, int expected_result, char* testname) {
  if (result == expected_result) {
    fprintf(stderr, "%s Test " COL_GREEN " PASSED\n" COL_STOP, testname);
    return 1;
  }
  else {
    fprintf(stderr, "%s Test " COL_RED " FAILED\n" COL_STOP, testname);
    gTestSuccess = 0;
    return 0;
  }
}