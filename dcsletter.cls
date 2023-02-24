%%  dcsletter.cls -- visual identity DCS letterhead
%%
%%  Copyright (c) 2008-2016 Francois Pitt <fpitt@cs.utoronto.ca>
%%  last updated at 13:29 (EST) on Fri 29 Jan 2016
%%
%%  This work may be distributed and/or modified under the conditions of
%%  the LaTeX Project Public License, either version 1.3 of this license
%%  or (at your option) any later version.
%%  The latest version of this license is in
%%      http://www.latex-project.org/lppl.txt
%%  and version 1.3 or later is part of all distributions of LaTeX
%%  version 2003/12/01 or later.
%%
%%  This work has the LPPL maintenance status "maintained".
%%
%%  The Current Maintainer of this work is
%%  Francois Pitt <fpitt@cs.utoronto.ca>.
%%
%%  This work consists of the files listed in the accompanying README.

%%  Minimal class for letters with new visual identity DCS letterhead.  Does
%%  *not* include any of the non-standard options from Jean-Francois Lamy's
%%  old 'ut-letter.sty' from 1986 (e.g., DCSPaper, long, full) -- all page
%%  layout and formatting (other than the letterhead) must be handled within
%%  the document, using standard LaTeX packages and macros.

%%%%  Identification.  Preliminary declarations.

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{dcsletter}[2016/01/29
v1.2 LaTeX2e class for DCS letterhead]

%%%%  Options.  Class and package loading.

\newif\ifdcscolour  % to control colour for letterhead
\DeclareOption{colour}{\dcscolourtrue}
\DeclareOption{nocolour}{\dcscolourfalse}

% All other options to be processed by base class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}

\ExecuteOptions{colour}  % default setting: use colour for letterhead
\ProcessOptions

\LoadClass{letter}

\RequirePackage{calc}  % to simplify length calculations
\RequirePackage{graphics}  % to include visual identity
\RequirePackage{xcolor}  % for letterhead footer text

%%%%  Declarations.

% Height of header and width of footer.
\newlength\DCSheadheight
\setlength\DCSheadheight{.85in}  % 27/32"
\newlength\DCSfootwidth
\setlength\DCSfootwidth{4.375in}  % 4 3/8"

% Horizontal and vertical offsets to position header and footer.
\newlength\DCSoddsidemarginoffset
\newlength\DCStopmarginoffset
\newlength\DCSbottommarginoffset

% Text colour for footer (official UofT colour specification).
\providecolor{Pantone655}{HTML}{002A5C}

% Bullet point for text of footer ($\bullet$ is too large).
\newcommand*\DCSfootbullet
   {\begin{picture}(3,2)(-1.5,-2.5)\put(0,0){\circle*{2}}\end{picture}}

% Redefine style for first page of letters.
\renewcommand\ps@firstpage
   {% Set offsets -- must be done here rather than above to take into account
    % any changes to page layout made in the document.
    \setlength\DCSoddsidemarginoffset{.75in-\oddsidemargin-\hoffset-1in}
      % 3/4" from left edge of paper to left edge of header and footer
    \setlength\DCStopmarginoffset
       {1in+\voffset+\topmargin+\headheight-\DCSheadheight-.5in}
      % 1/2" from top edge of paper to top edge of header
    \setlength\DCSbottommarginoffset{.5in-\paperheight+1in+\voffset
            +\topmargin+\headheight+\headsep+\textheight+\footskip}
      % 1/2" from bottom edge of paper to bottom edge of footer
    % Set header.
    \renewcommand\@oddhead{\parbox{\textwidth}
           {\hspace*{\DCSoddsidemarginoffset}\raisebox
               {\DCStopmarginoffset}[0pt][0pt]
               {\resizebox{!}{\DCSheadheight}
                   {\ifdcscolour\includegraphics{compsci_ublue}%
                    \else\includegraphics{compsci_k}\fi}}}}
    % Set footer.
    \renewcommand\@oddfoot{\parbox[b]{\textwidth}
           {\hspace*{\DCSoddsidemarginoffset}\raisebox
               {\DCSbottommarginoffset}[0pt][0pt]
               {\parbox[b]{\DCSfootwidth}
                   {\ifdcscolour\color{Pantone655}\fi
                    \fontsize{8pt}{10pt}\usefont{OT1}{txr}{m}{n}
                      % 8pt Times-Roman Medium Normal
                    Sandford Fleming Building, 10 King's College Road,
                    Room 3303, Toronto, ON M5S~3G4 Canada\\
                    Tel: +1~416~978-6025 {\DCSfootbullet}
                    Fax: +1~416~978-1931 {\DCSfootbullet}
                    www.cs.toronto.edu}}}}}
