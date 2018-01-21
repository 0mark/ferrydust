/*****************************************************************************
 *
 * sinac
 *
 * derived from sinac by
 * Author: Andres Erbsen
 *         https://github.com/andres-erbsen/sinac/blob/master/sinac.c
 *
 * derived from xautolock supplied by
 * Authors: Michel Eyckmans (MCE) & Stefan De Troch (SDT)
 *
 * --------------------------------------------------------------------------
 *
 * Copyright 1990,1992-1999,2001-2002 by Stefan De Troch and Michel Eyckmans.
 * Copyright 2005 by Stefan Siegl <stesie at brokenpipe.de>
 * Copyright 2007 by Christian Dietrich <stettberger at dokucode.de>
 *
 * Versions 2.0 and above of xautolock are available under version 2 of the
 * GNU GPL.
 *
 * sinac.c -L/usr/X11R6/lib -lX11 -lXss -lXext -o sinac
 *
 *****************************************************************************/

#include <stdlib.h>
#include <X11/Xos.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xatom.h>
#include <X11/Xresource.h>

#include <X11/extensions/scrnsaver.h>

#include <stdio.h>

#define VERSION "0.1.2"

static XScreenSaverInfo* xss_info = 0;

int
seconds_idle(Display *d)
{
  if (! xss_info )
    xss_info = XScreenSaverAllocInfo();
  XScreenSaverQueryInfo(d, DefaultRootWindow(d), xss_info);
  return xss_info->idle / 1000;

}

int
main (int argc, char* argv[])
{
  Display* d;
  int wait = 0, iwait = -1, i, idle;

  for (i = 1; i < argc; i++) {
    if ((strcmp(argv[i], "-w") == 0) && (i+1 < argc))
      wait = atoi(argv[++i]);
    else if (strcmp(argv[i], "-W") == 0) {
      if(i+1 < argc)
        iwait = atoi(argv[++i]);
      else
        iwait = 0;
    } else if (strcmp(argv[i], "-p") == 0)
      wait = 0;
    else {
      fprintf(stderr, "sinac - " VERSION ": %s [-w <seconds>] [-p]\n",
              argv[0]);
      return 1;
    }
  }

  if (!(d = XOpenDisplay (0))) {
    fprintf (stderr, "Couldn't connect to %s\n", XDisplayName (0));
    return 1;
  }
  (void) XSync (d, 0);

  if (wait>0)
    while ((idle = seconds_idle(d)) < wait)
      sleep(wait - idle - 1); // waiting for idle ... just wait as long as is need, then check, wait again
  else if(iwait>0) {
    while(((idle = seconds_idle(d))-iwait) < 0 && idle > 0) // waiting for either timeout OR end of UNidle -> check often to feel responsive!
      usleep(100000);
    if(idle<iwait)
      return 1;
  } else if(iwait==0)
    while(seconds_idle(d) > 0) // waiting for end of UNidle -> check often to feel responsive!
      usleep(100000);
  else
    fprintf(stdout, "%ld\n", seconds_idle(d));

  return 0;
}

