{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "d49d94bc-3116-4755-997e-a19f1dae69f2",
   "metadata": {},
   "source": [
    "# Week 1 Internship Task\n",
    "## Data Cleaning and Preliminary Analysis with R\n",
    "\n",
    "**Dataset:** SuperMarket Analysis\n",
    "\n",
    "**Objective:**\n",
    "The objective of this project is to perform data cleaning, preprocessing, transformation, and exploratory data analysis on a supermarket sales dataset using R."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "f094976e-7e51-4079-850c-363cbe12fc38",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'tidyverse' successfully unpacked and MD5 sums checked\n",
      "package 'janitor' successfully unpacked and MD5 sums checked\n",
      "package 'lubridate' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\Shreya Srinath\\AppData\\Local\\Temp\\RtmpaWFcAu\\downloaded_packages\n"
     ]
    }
   ],
   "source": [
    "install.packages(c(\"tidyverse\", \"janitor\", \"lubridate\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e4bebfbd-033e-4680-9531-89c2ae9d2485",
   "metadata": {},
   "source": [
    "## 1. Import Required Libraries"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "237f396d-afe8-4114-8fc9-ba1a8ee0d762",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────────────────────────────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.2.1     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.2.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.1     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.6.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 4.0.3     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.3.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.5     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.2\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.2.2     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n",
      "\n",
      "Attaching package: 'janitor'\n",
      "\n",
      "\n",
      "The following objects are masked from 'package:stats':\n",
      "\n",
      "    chisq.test, fisher.test\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "# Install packages if not already installed\n",
    "# install.packages(c(\"tidyverse\", \"janitor\", \"lubridate\"))\n",
    "\n",
    "library(tidyverse)\n",
    "library(janitor)\n",
    "library(lubridate)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "21c47c99-85b2-471a-8c2d-6b9ef314fe30",
   "metadata": {},
   "source": [
    "# 2. Load the Dataset"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "fbcea6a3-8410-42bc-a697-645efbb0f7e9",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 17</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Invoice.ID</th><th scope=col>Branch</th><th scope=col>City</th><th scope=col>Customer.type</th><th scope=col>Gender</th><th scope=col>Product.line</th><th scope=col>Unit.price</th><th scope=col>Quantity</th><th scope=col>Tax.5.</th><th scope=col>Sales</th><th scope=col>Date</th><th scope=col>Time</th><th scope=col>Payment</th><th scope=col>cogs</th><th scope=col>gross.margin.percentage</th><th scope=col>gross.income</th><th scope=col>Rating</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>750-67-8428</td><td>Alex</td><td>Yangon   </td><td>Member</td><td>Female</td><td>Health and beauty     </td><td>74.69</td><td>7</td><td>26.1415</td><td>548.9715</td><td>1/5/2019 </td><td>1:08:00 PM </td><td>Ewallet    </td><td>522.83</td><td>4.761905</td><td>26.1415</td><td>9.1</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>226-31-3081</td><td>Giza</td><td>Naypyitaw</td><td>Normal</td><td>Female</td><td>Electronic accessories</td><td>15.28</td><td>5</td><td> 3.8200</td><td> 80.2200</td><td>3/8/2019 </td><td>10:29:00 AM</td><td>Cash       </td><td> 76.40</td><td>4.761905</td><td> 3.8200</td><td>9.6</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>631-41-3108</td><td>Alex</td><td>Yangon   </td><td>Normal</td><td>Female</td><td>Home and lifestyle    </td><td>46.33</td><td>7</td><td>16.2155</td><td>340.5255</td><td>3/3/2019 </td><td>1:23:00 PM </td><td>Credit card</td><td>324.31</td><td>4.761905</td><td>16.2155</td><td>7.4</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>123-19-1176</td><td>Alex</td><td>Yangon   </td><td>Member</td><td>Female</td><td>Health and beauty     </td><td>58.22</td><td>8</td><td>23.2880</td><td>489.0480</td><td>1/27/2019</td><td>8:33:00 PM </td><td>Ewallet    </td><td>465.76</td><td>4.761905</td><td>23.2880</td><td>8.4</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>373-73-7910</td><td>Alex</td><td>Yangon   </td><td>Member</td><td>Female</td><td>Sports and travel     </td><td>86.31</td><td>7</td><td>30.2085</td><td>634.3785</td><td>2/8/2019 </td><td>10:37:00 AM</td><td>Ewallet    </td><td>604.17</td><td>4.761905</td><td>30.2085</td><td>5.3</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>699-14-3026</td><td>Giza</td><td>Naypyitaw</td><td>Member</td><td>Female</td><td>Electronic accessories</td><td>85.39</td><td>7</td><td>29.8865</td><td>627.6165</td><td>3/25/2019</td><td>6:30:00 PM </td><td>Ewallet    </td><td>597.73</td><td>4.761905</td><td>29.8865</td><td>4.1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 17\n",
       "\\begin{tabular}{r|lllllllllllllllll}\n",
       "  & Invoice.ID & Branch & City & Customer.type & Gender & Product.line & Unit.price & Quantity & Tax.5. & Sales & Date & Time & Payment & cogs & gross.margin.percentage & gross.income & Rating\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <int> & <dbl> & <dbl> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 750-67-8428 & Alex & Yangon    & Member & Female & Health and beauty      & 74.69 & 7 & 26.1415 & 548.9715 & 1/5/2019  & 1:08:00 PM  & Ewallet     & 522.83 & 4.761905 & 26.1415 & 9.1\\\\\n",
       "\t2 & 226-31-3081 & Giza & Naypyitaw & Normal & Female & Electronic accessories & 15.28 & 5 &  3.8200 &  80.2200 & 3/8/2019  & 10:29:00 AM & Cash        &  76.40 & 4.761905 &  3.8200 & 9.6\\\\\n",
       "\t3 & 631-41-3108 & Alex & Yangon    & Normal & Female & Home and lifestyle     & 46.33 & 7 & 16.2155 & 340.5255 & 3/3/2019  & 1:23:00 PM  & Credit card & 324.31 & 4.761905 & 16.2155 & 7.4\\\\\n",
       "\t4 & 123-19-1176 & Alex & Yangon    & Member & Female & Health and beauty      & 58.22 & 8 & 23.2880 & 489.0480 & 1/27/2019 & 8:33:00 PM  & Ewallet     & 465.76 & 4.761905 & 23.2880 & 8.4\\\\\n",
       "\t5 & 373-73-7910 & Alex & Yangon    & Member & Female & Sports and travel      & 86.31 & 7 & 30.2085 & 634.3785 & 2/8/2019  & 10:37:00 AM & Ewallet     & 604.17 & 4.761905 & 30.2085 & 5.3\\\\\n",
       "\t6 & 699-14-3026 & Giza & Naypyitaw & Member & Female & Electronic accessories & 85.39 & 7 & 29.8865 & 627.6165 & 3/25/2019 & 6:30:00 PM  & Ewallet     & 597.73 & 4.761905 & 29.8865 & 4.1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 17\n",
       "\n",
       "| <!--/--> | Invoice.ID &lt;chr&gt; | Branch &lt;chr&gt; | City &lt;chr&gt; | Customer.type &lt;chr&gt; | Gender &lt;chr&gt; | Product.line &lt;chr&gt; | Unit.price &lt;dbl&gt; | Quantity &lt;int&gt; | Tax.5. &lt;dbl&gt; | Sales &lt;dbl&gt; | Date &lt;chr&gt; | Time &lt;chr&gt; | Payment &lt;chr&gt; | cogs &lt;dbl&gt; | gross.margin.percentage &lt;dbl&gt; | gross.income &lt;dbl&gt; | Rating &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 750-67-8428 | Alex | Yangon    | Member | Female | Health and beauty      | 74.69 | 7 | 26.1415 | 548.9715 | 1/5/2019  | 1:08:00 PM  | Ewallet     | 522.83 | 4.761905 | 26.1415 | 9.1 |\n",
       "| 2 | 226-31-3081 | Giza | Naypyitaw | Normal | Female | Electronic accessories | 15.28 | 5 |  3.8200 |  80.2200 | 3/8/2019  | 10:29:00 AM | Cash        |  76.40 | 4.761905 |  3.8200 | 9.6 |\n",
       "| 3 | 631-41-3108 | Alex | Yangon    | Normal | Female | Home and lifestyle     | 46.33 | 7 | 16.2155 | 340.5255 | 3/3/2019  | 1:23:00 PM  | Credit card | 324.31 | 4.761905 | 16.2155 | 7.4 |\n",
       "| 4 | 123-19-1176 | Alex | Yangon    | Member | Female | Health and beauty      | 58.22 | 8 | 23.2880 | 489.0480 | 1/27/2019 | 8:33:00 PM  | Ewallet     | 465.76 | 4.761905 | 23.2880 | 8.4 |\n",
       "| 5 | 373-73-7910 | Alex | Yangon    | Member | Female | Sports and travel      | 86.31 | 7 | 30.2085 | 634.3785 | 2/8/2019  | 10:37:00 AM | Ewallet     | 604.17 | 4.761905 | 30.2085 | 5.3 |\n",
       "| 6 | 699-14-3026 | Giza | Naypyitaw | Member | Female | Electronic accessories | 85.39 | 7 | 29.8865 | 627.6165 | 3/25/2019 | 6:30:00 PM  | Ewallet     | 597.73 | 4.761905 | 29.8865 | 4.1 |\n",
       "\n"
      ],
      "text/plain": [
       "  Invoice.ID  Branch City      Customer.type Gender Product.line          \n",
       "1 750-67-8428 Alex   Yangon    Member        Female Health and beauty     \n",
       "2 226-31-3081 Giza   Naypyitaw Normal        Female Electronic accessories\n",
       "3 631-41-3108 Alex   Yangon    Normal        Female Home and lifestyle    \n",
       "4 123-19-1176 Alex   Yangon    Member        Female Health and beauty     \n",
       "5 373-73-7910 Alex   Yangon    Member        Female Sports and travel     \n",
       "6 699-14-3026 Giza   Naypyitaw Member        Female Electronic accessories\n",
       "  Unit.price Quantity Tax.5.  Sales    Date      Time        Payment     cogs  \n",
       "1 74.69      7        26.1415 548.9715 1/5/2019  1:08:00 PM  Ewallet     522.83\n",
       "2 15.28      5         3.8200  80.2200 3/8/2019  10:29:00 AM Cash         76.40\n",
       "3 46.33      7        16.2155 340.5255 3/3/2019  1:23:00 PM  Credit card 324.31\n",
       "4 58.22      8        23.2880 489.0480 1/27/2019 8:33:00 PM  Ewallet     465.76\n",
       "5 86.31      7        30.2085 634.3785 2/8/2019  10:37:00 AM Ewallet     604.17\n",
       "6 85.39      7        29.8865 627.6165 3/25/2019 6:30:00 PM  Ewallet     597.73\n",
       "  gross.margin.percentage gross.income Rating\n",
       "1 4.761905                26.1415      9.1   \n",
       "2 4.761905                 3.8200      9.6   \n",
       "3 4.761905                16.2155      7.4   \n",
       "4 4.761905                23.2880      8.4   \n",
       "5 4.761905                30.2085      5.3   \n",
       "6 4.761905                29.8865      4.1   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sales <- read.csv(\"SuperMarket Analysis.csv\")\n",
    "\n",
    "head(sales)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "95059513-bd1b-4517-89ae-34e3f54bc70c",
   "metadata": {},
   "source": [
    "# 3. Dataset Overview\n",
    "\n",
    "Before cleaning the data, it is important to understand its structure. This includes identifying the number of observations, variables, column names, data types, and basic descriptive statistics."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "4c79b407-37bd-463d-b9a5-caf85f7a3c39",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>1000</li><li>17</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 1000\n",
       "\\item 17\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 1000\n",
       "2. 17\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 1000   17"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(sales)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "a468c25a-4eea-42dc-aa69-e410b514bd0b",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Invoice.ID'</li><li>'Branch'</li><li>'City'</li><li>'Customer.type'</li><li>'Gender'</li><li>'Product.line'</li><li>'Unit.price'</li><li>'Quantity'</li><li>'Tax.5.'</li><li>'Sales'</li><li>'Date'</li><li>'Time'</li><li>'Payment'</li><li>'cogs'</li><li>'gross.margin.percentage'</li><li>'gross.income'</li><li>'Rating'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Invoice.ID'\n",
       "\\item 'Branch'\n",
       "\\item 'City'\n",
       "\\item 'Customer.type'\n",
       "\\item 'Gender'\n",
       "\\item 'Product.line'\n",
       "\\item 'Unit.price'\n",
       "\\item 'Quantity'\n",
       "\\item 'Tax.5.'\n",
       "\\item 'Sales'\n",
       "\\item 'Date'\n",
       "\\item 'Time'\n",
       "\\item 'Payment'\n",
       "\\item 'cogs'\n",
       "\\item 'gross.margin.percentage'\n",
       "\\item 'gross.income'\n",
       "\\item 'Rating'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Invoice.ID'\n",
       "2. 'Branch'\n",
       "3. 'City'\n",
       "4. 'Customer.type'\n",
       "5. 'Gender'\n",
       "6. 'Product.line'\n",
       "7. 'Unit.price'\n",
       "8. 'Quantity'\n",
       "9. 'Tax.5.'\n",
       "10. 'Sales'\n",
       "11. 'Date'\n",
       "12. 'Time'\n",
       "13. 'Payment'\n",
       "14. 'cogs'\n",
       "15. 'gross.margin.percentage'\n",
       "16. 'gross.income'\n",
       "17. 'Rating'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"Invoice.ID\"              \"Branch\"                 \n",
       " [3] \"City\"                    \"Customer.type\"          \n",
       " [5] \"Gender\"                  \"Product.line\"           \n",
       " [7] \"Unit.price\"              \"Quantity\"               \n",
       " [9] \"Tax.5.\"                  \"Sales\"                  \n",
       "[11] \"Date\"                    \"Time\"                   \n",
       "[13] \"Payment\"                 \"cogs\"                   \n",
       "[15] \"gross.margin.percentage\" \"gross.income\"           \n",
       "[17] \"Rating\"                 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "names(sales)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "e1ce534a-28aa-4ae1-8f07-88f0c093a3d7",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t1000 obs. of  17 variables:\n",
      " $ Invoice.ID             : chr  \"750-67-8428\" \"226-31-3081\" \"631-41-3108\" \"123-19-1176\" ...\n",
      " $ Branch                 : chr  \"Alex\" \"Giza\" \"Alex\" \"Alex\" ...\n",
      " $ City                   : chr  \"Yangon\" \"Naypyitaw\" \"Yangon\" \"Yangon\" ...\n",
      " $ Customer.type          : chr  \"Member\" \"Normal\" \"Normal\" \"Member\" ...\n",
      " $ Gender                 : chr  \"Female\" \"Female\" \"Female\" \"Female\" ...\n",
      " $ Product.line           : chr  \"Health and beauty\" \"Electronic accessories\" \"Home and lifestyle\" \"Health and beauty\" ...\n",
      " $ Unit.price             : num  74.7 15.3 46.3 58.2 86.3 ...\n",
      " $ Quantity               : int  7 5 7 8 7 7 6 10 2 3 ...\n",
      " $ Tax.5.                 : num  26.14 3.82 16.22 23.29 30.21 ...\n",
      " $ Sales                  : num  549 80.2 340.5 489 634.4 ...\n",
      " $ Date                   : chr  \"1/5/2019\" \"3/8/2019\" \"3/3/2019\" \"1/27/2019\" ...\n",
      " $ Time                   : chr  \"1:08:00 PM\" \"10:29:00 AM\" \"1:23:00 PM\" \"8:33:00 PM\" ...\n",
      " $ Payment                : chr  \"Ewallet\" \"Cash\" \"Credit card\" \"Ewallet\" ...\n",
      " $ cogs                   : num  522.8 76.4 324.3 465.8 604.2 ...\n",
      " $ gross.margin.percentage: num  4.76 4.76 4.76 4.76 4.76 ...\n",
      " $ gross.income           : num  26.14 3.82 16.22 23.29 30.21 ...\n",
      " $ Rating                 : num  9.1 9.6 7.4 8.4 5.3 4.1 5.8 8 7.2 5.9 ...\n"
     ]
    }
   ],
   "source": [
    "str(sales)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "8ace3727-5fad-4b18-bd12-6102a19bde79",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "     Invoice.ID         Branch            City        Customer.type \n",
       " Length   :1000   Length   :1000   Length   :1000   Length   :1000  \n",
       " N.unique :1000   N.unique :   3   N.unique :   3   N.unique :   2  \n",
       " N.blank  :   0   N.blank  :   0   N.blank  :   0   N.blank  :   0  \n",
       " Min.nchar:  11   Min.nchar:   4   Min.nchar:   6   Min.nchar:   6  \n",
       " Max.nchar:  11   Max.nchar:   5   Max.nchar:   9   Max.nchar:   6  \n",
       "                                                                    \n",
       "       Gender        Product.line    Unit.price       Quantity    \n",
       " Length   :1000   Length   :1000   Min.   :10.08   Min.   : 1.00  \n",
       " N.unique :   2   N.unique :   6   1st Qu.:32.88   1st Qu.: 3.00  \n",
       " N.blank  :   0   N.blank  :   0   Median :55.23   Median : 5.00  \n",
       " Min.nchar:   4   Min.nchar:  17   Mean   :55.67   Mean   : 5.51  \n",
       " Max.nchar:   6   Max.nchar:  22   3rd Qu.:77.94   3rd Qu.: 8.00  \n",
       "                                   Max.   :99.96   Max.   :10.00  \n",
       "     Tax.5.            Sales                Date             Time     \n",
       " Min.   : 0.5085   Min.   :  10.68   Length   :1000   Length   :1000  \n",
       " 1st Qu.: 5.9249   1st Qu.: 124.42   N.unique :  89   N.unique : 506  \n",
       " Median :12.0880   Median : 253.85   N.blank  :   0   N.blank  :   0  \n",
       " Mean   :15.3794   Mean   : 322.97   Min.nchar:   8   Min.nchar:  10  \n",
       " 3rd Qu.:22.4453   3rd Qu.: 471.35   Max.nchar:   9   Max.nchar:  11  \n",
       " Max.   :49.6500   Max.   :1042.65                                    \n",
       "      Payment          cogs        gross.margin.percentage  gross.income    \n",
       " Length   :1000   Min.   : 10.17   Min.   :4.762           Min.   : 0.5085  \n",
       " N.unique :   3   1st Qu.:118.50   1st Qu.:4.762           1st Qu.: 5.9249  \n",
       " N.blank  :   0   Median :241.76   Median :4.762           Median :12.0880  \n",
       " Min.nchar:   4   Mean   :307.59   Mean   :4.762           Mean   :15.3794  \n",
       " Max.nchar:  11   3rd Qu.:448.90   3rd Qu.:4.762           3rd Qu.:22.4453  \n",
       "                  Max.   :993.00   Max.   :4.762           Max.   :49.6500  \n",
       "     Rating      \n",
       " Min.   : 4.000  \n",
       " 1st Qu.: 5.500  \n",
       " Median : 7.000  \n",
       " Mean   : 6.973  \n",
       " 3rd Qu.: 8.500  \n",
       " Max.   :10.000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(sales)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "71f7061a-a6e0-4d7c-b58e-6fa0eaca4004",
   "metadata": {},
   "source": [
    "# 4. Data Quality Assessment\n",
    "\n",
    "Data quality assessment is performed to identify potential issues that may affect the analysis. The following checks are carried out:\n",
    "\n",
    "- Missing values\n",
    "- Duplicate records\n",
    "- Blank values\n",
    "- Data types"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "8f3cbe4d-4f00-4514-b15d-763c0cb37316",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Invoice.ID</dt><dd>0</dd><dt>Branch</dt><dd>0</dd><dt>City</dt><dd>0</dd><dt>Customer.type</dt><dd>0</dd><dt>Gender</dt><dd>0</dd><dt>Product.line</dt><dd>0</dd><dt>Unit.price</dt><dd>0</dd><dt>Quantity</dt><dd>0</dd><dt>Tax.5.</dt><dd>0</dd><dt>Sales</dt><dd>0</dd><dt>Date</dt><dd>0</dd><dt>Time</dt><dd>0</dd><dt>Payment</dt><dd>0</dd><dt>cogs</dt><dd>0</dd><dt>gross.margin.percentage</dt><dd>0</dd><dt>gross.income</dt><dd>0</dd><dt>Rating</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Invoice.ID] 0\n",
       "\\item[Branch] 0\n",
       "\\item[City] 0\n",
       "\\item[Customer.type] 0\n",
       "\\item[Gender] 0\n",
       "\\item[Product.line] 0\n",
       "\\item[Unit.price] 0\n",
       "\\item[Quantity] 0\n",
       "\\item[Tax.5.] 0\n",
       "\\item[Sales] 0\n",
       "\\item[Date] 0\n",
       "\\item[Time] 0\n",
       "\\item[Payment] 0\n",
       "\\item[cogs] 0\n",
       "\\item[gross.margin.percentage] 0\n",
       "\\item[gross.income] 0\n",
       "\\item[Rating] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Invoice.ID\n",
       ":   0Branch\n",
       ":   0City\n",
       ":   0Customer.type\n",
       ":   0Gender\n",
       ":   0Product.line\n",
       ":   0Unit.price\n",
       ":   0Quantity\n",
       ":   0Tax.5.\n",
       ":   0Sales\n",
       ":   0Date\n",
       ":   0Time\n",
       ":   0Payment\n",
       ":   0cogs\n",
       ":   0gross.margin.percentage\n",
       ":   0gross.income\n",
       ":   0Rating\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "             Invoice.ID                  Branch                    City \n",
       "                      0                       0                       0 \n",
       "          Customer.type                  Gender            Product.line \n",
       "                      0                       0                       0 \n",
       "             Unit.price                Quantity                  Tax.5. \n",
       "                      0                       0                       0 \n",
       "                  Sales                    Date                    Time \n",
       "                      0                       0                       0 \n",
       "                Payment                    cogs gross.margin.percentage \n",
       "                      0                       0                       0 \n",
       "           gross.income                  Rating \n",
       "                      0                       0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Check missing values\n",
    "colSums(is.na(sales))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6e6fa53a-6aeb-434f-a532-d8a421a62c67",
   "metadata": {},
   "source": [
    "**Observation:**\n",
    "\n",
    "The missing value analysis was performed for all variables. The output indicates whether any missing values are present in the dataset."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "5f32b83b-c367-4c33-aa16-52e71ad736e3",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(duplicated(sales))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d8bb9285-f58c-4bc4-846f-bcccfe073a19",
   "metadata": {},
   "source": [
    "**Observation:**\n",
    "\n",
    "Duplicate records were checked to ensure data consistency. Duplicate observations, if any, will be removed during the data cleaning phase."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "a52ff223-7692-4999-a3a1-e8020ff37fe2",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Invoice.ID</dt><dd>0</dd><dt>Branch</dt><dd>0</dd><dt>City</dt><dd>0</dd><dt>Customer.type</dt><dd>0</dd><dt>Gender</dt><dd>0</dd><dt>Product.line</dt><dd>0</dd><dt>Unit.price</dt><dd>0</dd><dt>Quantity</dt><dd>0</dd><dt>Tax.5.</dt><dd>0</dd><dt>Sales</dt><dd>0</dd><dt>Date</dt><dd>0</dd><dt>Time</dt><dd>0</dd><dt>Payment</dt><dd>0</dd><dt>cogs</dt><dd>0</dd><dt>gross.margin.percentage</dt><dd>0</dd><dt>gross.income</dt><dd>0</dd><dt>Rating</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Invoice.ID] 0\n",
       "\\item[Branch] 0\n",
       "\\item[City] 0\n",
       "\\item[Customer.type] 0\n",
       "\\item[Gender] 0\n",
       "\\item[Product.line] 0\n",
       "\\item[Unit.price] 0\n",
       "\\item[Quantity] 0\n",
       "\\item[Tax.5.] 0\n",
       "\\item[Sales] 0\n",
       "\\item[Date] 0\n",
       "\\item[Time] 0\n",
       "\\item[Payment] 0\n",
       "\\item[cogs] 0\n",
       "\\item[gross.margin.percentage] 0\n",
       "\\item[gross.income] 0\n",
       "\\item[Rating] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Invoice.ID\n",
       ":   0Branch\n",
       ":   0City\n",
       ":   0Customer.type\n",
       ":   0Gender\n",
       ":   0Product.line\n",
       ":   0Unit.price\n",
       ":   0Quantity\n",
       ":   0Tax.5.\n",
       ":   0Sales\n",
       ":   0Date\n",
       ":   0Time\n",
       ":   0Payment\n",
       ":   0cogs\n",
       ":   0gross.margin.percentage\n",
       ":   0gross.income\n",
       ":   0Rating\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "             Invoice.ID                  Branch                    City \n",
       "                      0                       0                       0 \n",
       "          Customer.type                  Gender            Product.line \n",
       "                      0                       0                       0 \n",
       "             Unit.price                Quantity                  Tax.5. \n",
       "                      0                       0                       0 \n",
       "                  Sales                    Date                    Time \n",
       "                      0                       0                       0 \n",
       "                Payment                    cogs gross.margin.percentage \n",
       "                      0                       0                       0 \n",
       "           gross.income                  Rating \n",
       "                      0                       0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colSums(sales == \"\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d23aa456-c013-472c-bbe8-6091f36a628b",
   "metadata": {},
   "source": [
    "**Observation:**\n",
    "\n",
    "Blank string values were identified to ensure that no empty entries exist in the dataset."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "61071d24-e113-4aa6-b9ba-4af790ab0b36",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Invoice.ID</dt><dd>'character'</dd><dt>Branch</dt><dd>'character'</dd><dt>City</dt><dd>'character'</dd><dt>Customer.type</dt><dd>'character'</dd><dt>Gender</dt><dd>'character'</dd><dt>Product.line</dt><dd>'character'</dd><dt>Unit.price</dt><dd>'numeric'</dd><dt>Quantity</dt><dd>'integer'</dd><dt>Tax.5.</dt><dd>'numeric'</dd><dt>Sales</dt><dd>'numeric'</dd><dt>Date</dt><dd>'character'</dd><dt>Time</dt><dd>'character'</dd><dt>Payment</dt><dd>'character'</dd><dt>cogs</dt><dd>'numeric'</dd><dt>gross.margin.percentage</dt><dd>'numeric'</dd><dt>gross.income</dt><dd>'numeric'</dd><dt>Rating</dt><dd>'numeric'</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Invoice.ID] 'character'\n",
       "\\item[Branch] 'character'\n",
       "\\item[City] 'character'\n",
       "\\item[Customer.type] 'character'\n",
       "\\item[Gender] 'character'\n",
       "\\item[Product.line] 'character'\n",
       "\\item[Unit.price] 'numeric'\n",
       "\\item[Quantity] 'integer'\n",
       "\\item[Tax.5.] 'numeric'\n",
       "\\item[Sales] 'numeric'\n",
       "\\item[Date] 'character'\n",
       "\\item[Time] 'character'\n",
       "\\item[Payment] 'character'\n",
       "\\item[cogs] 'numeric'\n",
       "\\item[gross.margin.percentage] 'numeric'\n",
       "\\item[gross.income] 'numeric'\n",
       "\\item[Rating] 'numeric'\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Invoice.ID\n",
       ":   'character'Branch\n",
       ":   'character'City\n",
       ":   'character'Customer.type\n",
       ":   'character'Gender\n",
       ":   'character'Product.line\n",
       ":   'character'Unit.price\n",
       ":   'numeric'Quantity\n",
       ":   'integer'Tax.5.\n",
       ":   'numeric'Sales\n",
       ":   'numeric'Date\n",
       ":   'character'Time\n",
       ":   'character'Payment\n",
       ":   'character'cogs\n",
       ":   'numeric'gross.margin.percentage\n",
       ":   'numeric'gross.income\n",
       ":   'numeric'Rating\n",
       ":   'numeric'\n",
       "\n"
      ],
      "text/plain": [
       "             Invoice.ID                  Branch                    City \n",
       "            \"character\"             \"character\"             \"character\" \n",
       "          Customer.type                  Gender            Product.line \n",
       "            \"character\"             \"character\"             \"character\" \n",
       "             Unit.price                Quantity                  Tax.5. \n",
       "              \"numeric\"               \"integer\"               \"numeric\" \n",
       "                  Sales                    Date                    Time \n",
       "              \"numeric\"             \"character\"             \"character\" \n",
       "                Payment                    cogs gross.margin.percentage \n",
       "            \"character\"               \"numeric\"               \"numeric\" \n",
       "           gross.income                  Rating \n",
       "              \"numeric\"               \"numeric\" "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sapply(sales, class)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "41e50bd8-c5f9-431a-ba71-848b1217c913",
   "metadata": {},
   "source": [
    "**Observation:**\n",
    "\n",
    "The data types of each variable were verified to ensure they are appropriate for analysis. Variables such as dates and categorical columns will be converted if required."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "82e6996d-f9d2-484b-bf28-6a1f17417a22",
   "metadata": {},
   "source": [
    "# 5. Data Cleaning\n",
    "\n",
    "The dataset is cleaned by addressing identified issues. This includes removing duplicate records, converting data types, standardizing column names, and preparing the data for further analysis."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "5888e8c4-fc75-49e1-81f6-1eb236d00744",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'invoice_id'</li><li>'branch'</li><li>'city'</li><li>'customer_type'</li><li>'gender'</li><li>'product_line'</li><li>'unit_price'</li><li>'quantity'</li><li>'tax_5'</li><li>'sales'</li><li>'date'</li><li>'time'</li><li>'payment'</li><li>'cogs'</li><li>'gross_margin_percentage'</li><li>'gross_income'</li><li>'rating'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'invoice\\_id'\n",
       "\\item 'branch'\n",
       "\\item 'city'\n",
       "\\item 'customer\\_type'\n",
       "\\item 'gender'\n",
       "\\item 'product\\_line'\n",
       "\\item 'unit\\_price'\n",
       "\\item 'quantity'\n",
       "\\item 'tax\\_5'\n",
       "\\item 'sales'\n",
       "\\item 'date'\n",
       "\\item 'time'\n",
       "\\item 'payment'\n",
       "\\item 'cogs'\n",
       "\\item 'gross\\_margin\\_percentage'\n",
       "\\item 'gross\\_income'\n",
       "\\item 'rating'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'invoice_id'\n",
       "2. 'branch'\n",
       "3. 'city'\n",
       "4. 'customer_type'\n",
       "5. 'gender'\n",
       "6. 'product_line'\n",
       "7. 'unit_price'\n",
       "8. 'quantity'\n",
       "9. 'tax_5'\n",
       "10. 'sales'\n",
       "11. 'date'\n",
       "12. 'time'\n",
       "13. 'payment'\n",
       "14. 'cogs'\n",
       "15. 'gross_margin_percentage'\n",
       "16. 'gross_income'\n",
       "17. 'rating'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"invoice_id\"              \"branch\"                 \n",
       " [3] \"city\"                    \"customer_type\"          \n",
       " [5] \"gender\"                  \"product_line\"           \n",
       " [7] \"unit_price\"              \"quantity\"               \n",
       " [9] \"tax_5\"                   \"sales\"                  \n",
       "[11] \"date\"                    \"time\"                   \n",
       "[13] \"payment\"                 \"cogs\"                   \n",
       "[15] \"gross_margin_percentage\" \"gross_income\"           \n",
       "[17] \"rating\"                 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sales <- clean_names(sales)\n",
    "\n",
    "names(sales)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "92ff9fba-9c29-4698-b703-d62f41e92fb5",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "'character'"
      ],
      "text/latex": [
       "'character'"
      ],
      "text/markdown": [
       "'character'"
      ],
      "text/plain": [
       "[1] \"character\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "class(sales$date)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "e249e69b-274e-4af0-85a4-0aa8e2bffaa2",
   "metadata": {},
   "outputs": [],
   "source": [
    "sales$date <- as.Date(sales$date, format = \"%m/%d/%Y\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "a5e7ad6c-ee68-4122-829b-87c1f3a06cf4",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "'Date'"
      ],
      "text/latex": [
       "'Date'"
      ],
      "text/markdown": [
       "'Date'"
      ],
      "text/plain": [
       "[1] \"Date\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "class(sales$date)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a8a69e1b-0afc-4277-b5f1-b40c43ba6355",
   "metadata": {},
   "source": [
    "# 6. Outlier Detection\n",
    "\n",
    "Outlier detection is an important preprocessing step because extreme values can influence statistical analysis and visualization. Boxplots are used to identify potential outliers in the numerical variables."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "ad7290f4-ed98-4b2b-ba07-7baf93f1a40e",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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\n6ktwdtpvbFm/Uf7xtJ98svJFOI97mzZM9SgbIX2I/ysb5sVolE3N94bPcU6T9cqGN6Uh0Vy3\nS+2hopbDzfAK31+FOqQcVzZ8XQeJDu+feGcJSThYM/AteIP81Bza6UbZsg8m/fHUn3wyexmu\nbEhV971+4/Rb6+Y2yiY6hKrFO+paN8pGSH9Yia+MVK/f7yqtDueXo1RZjLr+2+L2vo/mFfje\nkebnuox2fDX/C+9//a5TqpP+Z8hEh07qS6yqtD0fLR7O3zlEr+iE9BkLm3eqpzgf1QmHnsSH\nTov+lQgCzWKtz69G+8/dD2GSrKOyfzztJ5/sJceV+J1q+WX23SuS6ghUfeikPkdqVtuumZfT\nVxCjUVmfK6NP/dKvfgPwfI60PJ8jrVTnSOpDJ/Wo3eq8fIfz+da3w+H57D9v9rv5haR+A/B6\nVLetdO9zaQ+dttJLjtp7ibdxin7wUBl67p83+53/kNTUr/i3Sy6Pmh3L+6HTufJTc1dM1bFs\njkNPA043VkZGl9k/TX/o5Jt6eN5IhI3VHpp8qe5Gl+0ye9FwtfzQSXzzGDX18PyNaHs8KUBI\n12No0XqRv28hf6dfe+ikvHnM6aQfXlYPz8u3x3P8h1TLj6G1K1o9XK0mvXnMST+8rD5HMtoe\n/kOqnB9Dy4erxZSHTlmGl8XD80bbw39I2Y6hReTD1eLf+Sq9eUyW4WXt8LzRlRc+d86+++2f\nxCePwmvZlMPV6t/5qrx5TMPp97Mbo7cPnK+Vxro9hv6uVN9gxCej6uFq9e98zfbzSE4ZvX3g\nP6Q09Pb81Cej6uHq7p52ut/56v7mMeLhefnbB8+ZX0jyk1HxcHX7myiEv/NVTnzRr3p4Xr09\nnuR0Y2Xk/ccA1L/zVU190a96eN5IsJBEt8j1fC2b+ne+qukv+n2ceI/6J6qf5HNn+pVgZatP\nRuU/SKb+na9i6u8/6nu7c9HqMzRvKsoHBxoeb++Vg/qiX/XwvNFPVAfb+IqdVXgyaviDZGbk\nF/2Kh+flP1H9nBmGpGT3g2RmlCOoHe3wvH75nnvaTz7Z+7yFdHK5SFkZ7ahPI6RnON14mL1g\nO6Zk+Nv3d1SEFGxnIiQHml/rcjqtVL8ezOa3kKsFW3jdyv5ehn4j3dCy2+dVl/QY/RZytWAL\nL1zZx89e1FiMy++4Pf+tWX/8fqToYn8HNFNdfuu6av0Vshn8fxW57uW8Ud1sY2a6X51y0l0b\n5/z2aE+KE5LqEpz7Ibn890fMwuLyiqS6h4bRbyFX8x1SjktwbnMr4tD88y7nSG7v6mTE+cLP\n8MOLAlIAAAHsSURBVBIc91baa+MI6UNir98S7aR3/SnE/PbSNGS9OCiD7x0pxy/XJSQ/DH95\nsprvhc+yotW395ob4V1/CCmwda4bTs6E/K4/ZZhfSN5vgexd1rv+xN0mYRf8Zd5vyu9d1m9E\nhJSR+DJ79a+JmRv1XX8GCCkf+WX215tt2Nz/LDz1XX8GCCkf/StH92tEfN5+MYCcN+UnpHzi\nrttSZbwpf9yN7X/BC7nMHs8gpHwKucy+GFnvrU1I+RTyzncxsm6GuNvY/4ITki9Z760ddxuH\nXXAYyXpvbULCXHCEMIqVgWnkIW0Wp9NhEf0HoP2HxHfAsrW/r6pqNm/okvzvnIRUtmXathcQ\ne/2duU8Ks3Nyi2E3tPf+7m7tVUceaGjEWXhuMeyE+N7fbZTNL54mpA+JvaKLob739zLtd81N\nbzm0+xBuMeyD+t7f7U1A183sQl+P7z+k+1gDtxj2QH3v79Oman+yaRH7RnlxQuIWwz6o7/1d\nCP8hwRf1vb8LQUiYSHzvb65swExp7/3NlQ2AAFc2AAJc2YCZam9+8qV614crGzBP19txia59\n5MoGzJL6TrVc2YBZkt87nSsbMEf8No9RrAxMU/P7pcYQEiaS/8bD7VL5Bq8RQsI0aej9Gea8\nKf/nEBKmUYe0KeP3Vf0Pb7iqfHkuOOgAAAAASUVORK5CYII=",
      "text/plain": [
       "Plot with title \"Boxplot of Numerical Variables\""
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Select only numeric columns\n",
    "numeric_data <- sales %>%\n",
    "  select(where(is.numeric))\n",
    "\n",
    "# Display boxplots\n",
    "boxplot(numeric_data,\n",
    "        main = \"Boxplot of Numerical Variables\",\n",
    "        las = 2,\n",
    "        col = \"lightblue\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "4ee36ddd-f6c3-408d-bbe2-55e45083d4a2",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>unit_price</dt><dd>0</dd><dt>quantity</dt><dd>0</dd><dt>tax_5</dt><dd>9</dd><dt>sales</dt><dd>9</dd><dt>cogs</dt><dd>9</dd><dt>gross_margin_percentage</dt><dd>0</dd><dt>gross_income</dt><dd>9</dd><dt>rating</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[unit\\textbackslash{}\\_price] 0\n",
       "\\item[quantity] 0\n",
       "\\item[tax\\textbackslash{}\\_5] 9\n",
       "\\item[sales] 9\n",
       "\\item[cogs] 9\n",
       "\\item[gross\\textbackslash{}\\_margin\\textbackslash{}\\_percentage] 0\n",
       "\\item[gross\\textbackslash{}\\_income] 9\n",
       "\\item[rating] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "unit_price\n",
       ":   0quantity\n",
       ":   0tax_5\n",
       ":   9sales\n",
       ":   9cogs\n",
       ":   9gross_margin_percentage\n",
       ":   0gross_income\n",
       ":   9rating\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "             unit_price                quantity                   tax_5 \n",
       "                      0                       0                       9 \n",
       "                  sales                    cogs gross_margin_percentage \n",
       "                      9                       9                       0 \n",
       "           gross_income                  rating \n",
       "                      9                       0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "detect_outliers <- function(x){\n",
    "  Q1 <- quantile(x, 0.25)\n",
    "  Q3 <- quantile(x, 0.75)\n",
    "  IQR_value <- IQR(x)\n",
    "\n",
    "  lower <- Q1 - 1.5 * IQR_value\n",
    "  upper <- Q3 + 1.5 * IQR_value\n",
    "\n",
    "  sum(x < lower | x > upper)\n",
    "}\n",
    "\n",
    "sapply(numeric_data, detect_outliers)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "e4d27f9d-00a6-4d93-a475-817c6f8dfa87",
   "metadata": {},
   "source": [
    "# 7. Data Normalization\n",
    "\n",
    "Normalization scales numerical variables to a comparable range. This is useful for machine learning algorithms and helps prevent variables with larger scales from dominating the analysis."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "dd1b0cfc-2232-498a-a38d-e0b7e994388f",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 6 × 1 of type dbl</caption>\n",
       "<tbody>\n",
       "\t<tr><td> 0.91914693</td></tr>\n",
       "\t<tr><td>-0.98723557</td></tr>\n",
       "\t<tr><td> 0.07141032</td></tr>\n",
       "\t<tr><td> 0.67544187</td></tr>\n",
       "\t<tr><td> 1.26649176</td></tr>\n",
       "\t<tr><td> 1.23899114</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 6 × 1 of type dbl\n",
       "\\begin{tabular}{l}\n",
       "\t  0.91914693\\\\\n",
       "\t -0.98723557\\\\\n",
       "\t  0.07141032\\\\\n",
       "\t  0.67544187\\\\\n",
       "\t  1.26649176\\\\\n",
       "\t  1.23899114\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 6 × 1 of type dbl\n",
       "\n",
       "|  0.91914693 |\n",
       "| -0.98723557 |\n",
       "|  0.07141032 |\n",
       "|  0.67544187 |\n",
       "|  1.26649176 |\n",
       "|  1.23899114 |\n",
       "\n"
      ],
      "text/plain": [
       "     [,1]       \n",
       "[1,]  0.91914693\n",
       "[2,] -0.98723557\n",
       "[3,]  0.07141032\n",
       "[4,]  0.67544187\n",
       "[5,]  1.26649176\n",
       "[6,]  1.23899114"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sales$sales_normalized <- scale(sales$sales)\n",
    "\n",
    "head(sales$sales_normalized)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ca62562e-ba59-4565-8c30-28af1a2730dc",
   "metadata": {},
   "source": [
    "# 8. Encoding Categorical Variables\n",
    "\n",
    "Categorical variables are encoded into numeric representations. This preprocessing step is useful for machine learning models that require numerical input."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "adb884f0-48c1-47f9-bfcc-e2b9a1dedeb1",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>gender</th><th scope=col>gender_encoded</th><th scope=col>payment</th><th scope=col>payment_encoded</th><th scope=col>customer_type</th><th scope=col>customer_type_encoded</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Female</td><td>1</td><td>Ewallet    </td><td>3</td><td>Member</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>Female</td><td>1</td><td>Cash       </td><td>1</td><td>Normal</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Female</td><td>1</td><td>Credit card</td><td>2</td><td>Normal</td><td>2</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>Female</td><td>1</td><td>Ewallet    </td><td>3</td><td>Member</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>Female</td><td>1</td><td>Ewallet    </td><td>3</td><td>Member</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>Female</td><td>1</td><td>Ewallet    </td><td>3</td><td>Member</td><td>1</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & gender & gender\\_encoded & payment & payment\\_encoded & customer\\_type & customer\\_type\\_encoded\\\\\n",
       "  & <chr> & <dbl> & <chr> & <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & Female & 1 & Ewallet     & 3 & Member & 1\\\\\n",
       "\t2 & Female & 1 & Cash        & 1 & Normal & 2\\\\\n",
       "\t3 & Female & 1 & Credit card & 2 & Normal & 2\\\\\n",
       "\t4 & Female & 1 & Ewallet     & 3 & Member & 1\\\\\n",
       "\t5 & Female & 1 & Ewallet     & 3 & Member & 1\\\\\n",
       "\t6 & Female & 1 & Ewallet     & 3 & Member & 1\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | gender &lt;chr&gt; | gender_encoded &lt;dbl&gt; | payment &lt;chr&gt; | payment_encoded &lt;dbl&gt; | customer_type &lt;chr&gt; | customer_type_encoded &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 1 | Female | 1 | Ewallet     | 3 | Member | 1 |\n",
       "| 2 | Female | 1 | Cash        | 1 | Normal | 2 |\n",
       "| 3 | Female | 1 | Credit card | 2 | Normal | 2 |\n",
       "| 4 | Female | 1 | Ewallet     | 3 | Member | 1 |\n",
       "| 5 | Female | 1 | Ewallet     | 3 | Member | 1 |\n",
       "| 6 | Female | 1 | Ewallet     | 3 | Member | 1 |\n",
       "\n"
      ],
      "text/plain": [
       "  gender gender_encoded payment     payment_encoded customer_type\n",
       "1 Female 1              Ewallet     3               Member       \n",
       "2 Female 1              Cash        1               Normal       \n",
       "3 Female 1              Credit card 2               Normal       \n",
       "4 Female 1              Ewallet     3               Member       \n",
       "5 Female 1              Ewallet     3               Member       \n",
       "6 Female 1              Ewallet     3               Member       \n",
       "  customer_type_encoded\n",
       "1 1                    \n",
       "2 2                    \n",
       "3 2                    \n",
       "4 1                    \n",
       "5 1                    \n",
       "6 1                    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sales$gender_encoded <- as.numeric(as.factor(sales$gender))\n",
    "sales$payment_encoded <- as.numeric(as.factor(sales$payment))\n",
    "sales$customer_type_encoded <- as.numeric(as.factor(sales$customer_type))\n",
    "\n",
    "head(sales[, c(\"gender\", \"gender_encoded\",\n",
    "               \"payment\", \"payment_encoded\",\n",
    "               \"customer_type\", \"customer_type_encoded\")])"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ca60b8a2-f175-436f-adaf-c724021ffd0f",
   "metadata": {},
   "source": [
    "# 9. Feature Engineering\n",
    "\n",
    "Feature engineering involves creating new variables from the existing dataset to enhance analysis. In this section, new features such as Month, Day of the Week, Hour of Transaction, and Time Period are created from the Date and Time columns."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "14a6fd12-36e8-4c1a-bec5-62cc54342c56",
   "metadata": {},
   "outputs": [],
   "source": [
    "library(lubridate)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "e3969e6e-bed3-4ba1-bf5d-9ac83f741661",
   "metadata": {},
   "outputs": [],
   "source": [
    "# Create Month\n",
    "sales$month <- month(sales$date, label = TRUE)\n",
    "\n",
    "# Create Day of Week\n",
    "sales$day <- weekdays(sales$date)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "d194b940-6f7d-4112-a48d-5fb4f8544cf0",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'1:08:00 PM'</li><li>'10:29:00 AM'</li><li>'1:23:00 PM'</li><li>'8:33:00 PM'</li><li>'10:37:00 AM'</li><li>'6:30:00 PM'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item '1:08:00 PM'\n",
       "\\item '10:29:00 AM'\n",
       "\\item '1:23:00 PM'\n",
       "\\item '8:33:00 PM'\n",
       "\\item '10:37:00 AM'\n",
       "\\item '6:30:00 PM'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. '1:08:00 PM'\n",
       "2. '10:29:00 AM'\n",
       "3. '1:23:00 PM'\n",
       "4. '8:33:00 PM'\n",
       "5. '10:37:00 AM'\n",
       "6. '6:30:00 PM'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"1:08:00 PM\"  \"10:29:00 AM\" \"1:23:00 PM\"  \"8:33:00 PM\"  \"10:37:00 AM\"\n",
       "[6] \"6:30:00 PM\" "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Convert time column to character\n",
    "sales$time <- as.character(sales$time)\n",
    "\n",
    "# Display sample values\n",
    "head(sales$time)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "09b85cea-6abb-48d7-8127-91fcfca5d05a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>&lt;NA&gt;</li><li>10</li><li>&lt;NA&gt;</li><li>&lt;NA&gt;</li><li>10</li><li>&lt;NA&gt;</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item <NA>\n",
       "\\item 10\n",
       "\\item <NA>\n",
       "\\item <NA>\n",
       "\\item 10\n",
       "\\item <NA>\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. &lt;NA&gt;\n",
       "2. 10\n",
       "3. &lt;NA&gt;\n",
       "4. &lt;NA&gt;\n",
       "5. 10\n",
       "6. &lt;NA&gt;\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] NA 10 NA NA 10 NA"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Extract hour from the time column\n",
    "\n",
    "sales$hour <- suppressWarnings(\n",
    "  as.numeric(substr(trimws(sales$time), 1, 2))\n",
    ")\n",
    "\n",
    "# Check the result\n",
    "head(sales$hour)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "3daaf3ac-f78a-4cf0-8718-c5aad671bcee",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "720"
      ],
      "text/latex": [
       "720"
      ],
      "text/markdown": [
       "720"
      ],
      "text/plain": [
       "[1] 720"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(sales$hour))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "594c5cfb-fe63-491c-9867-d3da3406ffab",
   "metadata": {},
   "outputs": [],
   "source": [
    "# Extract hour using lubridate\n",
    "\n",
    "sales$hour <- hour(parse_date_time(\n",
    "  sales$time,\n",
    "  orders = c(\"H:M:S\", \"H:M\", \"I:M p\", \"I:M:S p\")\n",
    "))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "b834dfaa-6e19-4b56-84a7-d3c0bc1f03f6",
   "metadata": {},
   "outputs": [],
   "source": [
    "sales$time_period <- case_when(\n",
    "\n",
    "  sales$hour >= 0 & sales$hour < 12 ~ \"Morning\",\n",
    "\n",
    "  sales$hour >= 12 & sales$hour < 17 ~ \"Afternoon\",\n",
    "\n",
    "  sales$hour >= 17 & sales$hour <= 23 ~ \"Evening\",\n",
    "\n",
    "  TRUE ~ \"Unknown\"\n",
    "\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "c3a31b10-833a-4daf-b035-c53f9b09a997",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>date</th><th scope=col>time</th><th scope=col>month</th><th scope=col>day</th><th scope=col>hour</th><th scope=col>time_period</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>2019-01-05</td><td>1:08:00 PM </td><td>Jan</td><td>Saturday</td><td>13</td><td>Afternoon</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2019-03-08</td><td>10:29:00 AM</td><td>Mar</td><td>Friday  </td><td>10</td><td>Morning  </td></tr>\n",
       "\t<tr><th scope=row>3</th><td>2019-03-03</td><td>1:23:00 PM </td><td>Mar</td><td>Sunday  </td><td>13</td><td>Afternoon</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2019-01-27</td><td>8:33:00 PM </td><td>Jan</td><td>Sunday  </td><td>20</td><td>Evening  </td></tr>\n",
       "\t<tr><th scope=row>5</th><td>2019-02-08</td><td>10:37:00 AM</td><td>Feb</td><td>Friday  </td><td>10</td><td>Morning  </td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2019-03-25</td><td>6:30:00 PM </td><td>Mar</td><td>Monday  </td><td>18</td><td>Evening  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 6\n",
       "\\begin{tabular}{r|llllll}\n",
       "  & date & time & month & day & hour & time\\_period\\\\\n",
       "  & <date> & <chr> & <ord> & <chr> & <int> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 2019-01-05 & 1:08:00 PM  & Jan & Saturday & 13 & Afternoon\\\\\n",
       "\t2 & 2019-03-08 & 10:29:00 AM & Mar & Friday   & 10 & Morning  \\\\\n",
       "\t3 & 2019-03-03 & 1:23:00 PM  & Mar & Sunday   & 13 & Afternoon\\\\\n",
       "\t4 & 2019-01-27 & 8:33:00 PM  & Jan & Sunday   & 20 & Evening  \\\\\n",
       "\t5 & 2019-02-08 & 10:37:00 AM & Feb & Friday   & 10 & Morning  \\\\\n",
       "\t6 & 2019-03-25 & 6:30:00 PM  & Mar & Monday   & 18 & Evening  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 6\n",
       "\n",
       "| <!--/--> | date &lt;date&gt; | time &lt;chr&gt; | month &lt;ord&gt; | day &lt;chr&gt; | hour &lt;int&gt; | time_period &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| 1 | 2019-01-05 | 1:08:00 PM  | Jan | Saturday | 13 | Afternoon |\n",
       "| 2 | 2019-03-08 | 10:29:00 AM | Mar | Friday   | 10 | Morning   |\n",
       "| 3 | 2019-03-03 | 1:23:00 PM  | Mar | Sunday   | 13 | Afternoon |\n",
       "| 4 | 2019-01-27 | 8:33:00 PM  | Jan | Sunday   | 20 | Evening   |\n",
       "| 5 | 2019-02-08 | 10:37:00 AM | Feb | Friday   | 10 | Morning   |\n",
       "| 6 | 2019-03-25 | 6:30:00 PM  | Mar | Monday   | 18 | Evening   |\n",
       "\n"
      ],
      "text/plain": [
       "  date       time        month day      hour time_period\n",
       "1 2019-01-05 1:08:00 PM  Jan   Saturday 13   Afternoon  \n",
       "2 2019-03-08 10:29:00 AM Mar   Friday   10   Morning    \n",
       "3 2019-03-03 1:23:00 PM  Mar   Sunday   13   Afternoon  \n",
       "4 2019-01-27 8:33:00 PM  Jan   Sunday   20   Evening    \n",
       "5 2019-02-08 10:37:00 AM Feb   Friday   10   Morning    \n",
       "6 2019-03-25 6:30:00 PM  Mar   Monday   18   Evening    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(sales[, c(\n",
    "  \"date\",\n",
    "  \"time\",\n",
    "  \"month\",\n",
    "  \"day\",\n",
    "  \"hour\",\n",
    "  \"time_period\"\n",
    ")])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "0841459d-2452-4306-8d62-f1e1eb10981b",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(sales$hour))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "38891b82-b390-471c-aeda-8d38b2d8b775",
   "metadata": {},
   "source": [
    "# 10. Exploratory Data Analysis\n",
    "\n",
    "Exploratory Data Analysis (EDA) helps understand the distribution of variables, identify trends, compare categories, and uncover relationships between variables. The following visualizations provide initial business insights from the supermarket sales dataset."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 29,
   "id": "d814f3b9-f505-4a9e-9ea1-2854098eee80",
   "metadata": {},
   "outputs": [],
   "source": [
    "dir.create(\"Graphs\", showWarnings = FALSE)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "62e4a2d0-2329-4ad8-acb6-b589af920e39",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"downloaded length 2161500 != reported length 3827652\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/corrplot_0.95.zip': Timeout of 60 seconds was reached\"\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Error in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...) : \n",
      "  download from 'https://cran.r-project.org/bin/windows/contrib/4.6/corrplot_0.95.zip' failed\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'corrplot' failed\"\n",
      "corrplot 0.95 loaded\n",
      "\n"
     ]
    }
   ],
   "source": [
    "install.packages(\"corrplot\")\n",
    "library(corrplot)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "id": "004211c3-f8eb-44fe-b596-d5f6c971b092",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<strong>agg_record_4bec60f51fa6:</strong> 2"
      ],
      "text/latex": [
       "\\textbf{agg\\textbackslash{}\\_record\\textbackslash{}\\_4bec60f51fa6:} 2"
      ],
      "text/markdown": [
       "**agg_record_4bec60f51fa6:** 2"
      ],
      "text/plain": [
       "agg_record_4bec60f51fa6 \n",
       "                      2 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nd2a6UOOPMWUdbVxDN8ZRC/OaSyu18eYkrCAlK3HMppRJUoIsKxUUJdNumJVpKahjgFr5i/vH\n05w5cg7nwDlHDj3n/VrPH+z9fJ+zv50Wq297P3tjfhR2gcW2JGq/NlpZWbl06VJjwTQ5OXnt\n2rVGv9Fpm3778ssvLRZLZmam21FOnTolqVevXr5N3rD1tfVjOrUd06nt1tfWNzfgsd/dO6ZT\nW5+k8cHr61NvCEu9IeyD152n4RhQc/JEyct5RmfJy3nn6mq9T2Pba+vHdWk3rku7bY18G04D\nPt+/L2tm+rgu7bJmpn9z8oT3aRT//ZXYDiGxHUKK//5KcwMKVq+K7RDifQ6Sil59ZXhEyPCI\nkKJXnafhNMDtU821bkdN8IQDwRMOrNtR4zTgwy+/m5F3LHjCgRl5x6prL0qqrr24cutp46mV\nW0/7Jo1dZ4OnHQ6ednjdrrOOd41b9pf93ZXv1TXo8dLKr78Kevst53lWHQ96+62gt99aV3Xc\ndSdp+DaNVsKP34bl8mUPLi8HbQEsxQa6ioqKqKgoW7OgoKCgoEBSSkrKlClTMjIyFi1alJWV\nJSknJ0fS1KlT3X7moUOHJLVp02bp0qUZGRlWq3X27Nk9evTwPtsdmwsXpU1aVlgiKT0xITgk\n9GdjEpsY8PGu0h2bN3mfg6TyosLl0yfPLyiWNDdpVHBo6JBfJroNeG/92pfmP7K8bL+kGdED\nvq2rG2ud4U0aZVsKl1h//9SmYkkz7x4VHBoaPTrRbcCJo0fSE4Y/tak4deYjEwf07jMwavTv\nJnmTxvtvbpo3ZWL25q2SrGPig0NC77zr7qYEnD5xYvO6Nc9mzvZmdJv33tz02JSJz23ZKilt\ndHyb0NARV6bhNMDtU831xp66CSu+emduL0lx878IDfrJ2MHt7AOOnLoQ8+hn78ztlfmfnXr8\noXJwr+DJ8RH/KK+bvvLYl3+9+fsL9f0eOlj77eX0xOu9SuPDcxOeP/nOn/5DUtzi46HXWcYO\nvKJ6/i6rp/HDwaoLt837esX9HYxmdd2lNTvPznrVN8WlpOrz59ccP/bnQwed53nyxPgDH707\nJFrSyPKy0GuuGduxk9NO0vBhGq0E38ZVwoxdYLEtidp+yM7OlrR9+3ZjwfTw4cOSUlNTJYWH\nh2/cuDE7O7uiomLHjh0LFizIz89vSn1WW1srKSoqKiMjwxiiZ8+e1dXV3uf/SXmZpFtuj7nl\n9hhbs4kBRX972fsEDJ/u2SWp39DofkOjbU23AS/Nf0RSx27dO3brbmt6o7J8l6TIoTGRQ2Ns\nTbcBe7YWG53tO3baUFXnZVUn6ePyMkkDomMGRMfYmk0JSI7seabmGy9Htzmwu0zSrdExt0bH\n2JpuA9w+1Vxlh76VNKxvyLC+IbamvaJ9Z4yAzmE//W51/8nxEZImx0d8t7p/57Cfdr/+Wkmz\n8qu8TeOL85KG9Q4a1jvI1nTqmeLasbe1mTzih+qzx8yj35zz5ZxE9/ff/ebixUbzrK2VNCw8\nfFh4uK3ptJM0fJhGK+H3b8Nyud6Dy5sRWwaFXaDLysqqr6/v3bt3RUVFQUGBMS1nk5SUlJSU\nlJmZuXDhwqSkpJSUlKZ8plHP7d271ygWi4uLJW3YsMH7bNc8/ZSLpouAz/bvGzg81vsEDK8t\nW+yi2VjA1MXPSDr51ZGTXx2RNGPFSi/TWPeXp1w0Gwso9dG0pc0LS5500XQR8ODji6bMecxX\naeRdOUqeQxpOA9w+1VxPbDzpoinpjT11Lh7feuCspBWTu3qbRmGNi6bNh0fP52w7M3nEv99P\neOLXEfOS23s5ur0n+/Sb17tPY3cXHf7csem0kzR8mEYrwbdxlbAUC2VmZi5YsKCxu3PmzLnj\njjskbd++vYkf2GCrREJCgqS0tLSmLONeJf/Iy035Y4a/Rjck3D/p830VM6IHGM2oUaP9kkbZ\nlsK7Jj7wetbyVfPm/H7ewnumebUc7I2UB//or6H96I09Z6YmRCwrPDUrv+qJ1C72S64z8o7l\nlJyemhBhTOO1gJx36yTF9gu29aT/Isy3Q6T36OnbD/QMabRCfv82fhQvzHmAGbtAl5OTs2DB\nAqvVWlxcvHfv3qoqb9eAWqGjhw52u6lP5xu7+zeN8qLCt1Y///S28ieK3pf0fzve91cmb77w\n/J1J96z4oHzVvDlbXsrzVxoBK6fk9K9jwvY92WdWfpX9Vonlk7q+M7dXTslpX+2fcK267lLO\ntjOzEsPD2vAfAgQiy6XLHlz+zto9fp8DXVpamqSsrKyEhIRBgwYFBQU1CFi4cKHVarVarQsX\nLmziZyYnJzueSGy1Wr3P1jM7NxcOjvu5v0a3KX4pT1LXPn17DrhN0uKJ/+XHZDrd2L1bn36S\nnn3YbzN2gaz79df26xokafrKY/b9xpt5DTqvkgNfX5AU3eu6FhgLQIuhsIMkVVZWSqqpqVmy\nZIl9v7FJ1ijsbBtm3UpKSpJUUlJiNI0ffvvb33qcnnF8yZhObe/775n2/Q2ajj1G87nH5kyL\nv8N20InHJ54YJ5Wk3hD2q/Q/2fc3aDr2GM3yokLPxm3AOL5kXJd29z50xT9sg6Zjj9F0DPOM\ncXxJbIeQiRl/tu9v0HTscQzwiUlXfuwkh1GcBrh9qrlmJXd00XTa42jsYG8P5ZmVGO6iadh7\n5LykgTf6s7Cb3fMmx6bTTtJosTRaiRb4Ntg8AVOx/VWx/Px8SZGRkRaLpX379vYv29XU1CQn\nJ1ut1kGDBg0aNMhqtSYnJ9fUOH8L2964ceOSkpJGjRplnI03atQoq9VqvGnnmc0nzhjXoBFx\nkj7eVfrxrlJJkUOijQCj7JPkNMD2uO3TPEsj/+ta4xowfKSkg7vLDu4uk9R38O1GgFH2SXIa\nYOyWOLi77NihT+XF5okNVXXGdduIkZI+2V36ye5SSTcP+SENo+yT5DTA1nni6BFJGdmrPEtj\n2z/PGdfgEXGS9peV7i8rlXTLv/6lGGWfpMYCfGtobJykj8pKPyorldR/6A+jGGfUNRbQ2FMe\ni+8fKmnnp+d2fnpOUnSfNka/cUadfcCRUxckrZ7eTdKywlPBEw5U1140nvL+Hbv4yGBJOz/7\nfudn38tuWs7+yLpD1RckhftjHdY4h0xSXESEpJ01NTtraiRFh4U11kkaVzuNVoJvw3tsngg4\nxcXF9n9VLCUlpa6uzliQffTRR8ePHx8ZGWncys3NlTR79g/HjM2ePTs7Ozs3N/fhhx92PUTn\nzp1zc3NffPFFY3tsfn5+YmKi60eaKCo2Lv3pv6YnJkia/Vxeg0PsmhLgEwNGxE1d/MzcpFGS\nZqxY2eAQu8YCht/zG0m2TqPpjYEj4h5cunzm3aMkZWSvanCIXWMBA0fEZWSvsnXG/srbNIaO\njJ+57FnrmHhJ83JfuNPhHDi3AT4xdGT8rP99Nm10vKT/yX3B8Tg6pwFun2qu+P6hKyZ3jZv/\nhaTV07s1OMTOCFg9vZst4N6fhUu6785wST3+UDl2cNtXH+ru+FSz04gMXnF/h7jFxyWtfqBj\ng0PsDDnbzkjy7wt2P4/okBV5y8jyMkkv9r/VOJPMaSdptFgarURLfBsm3Txh4W89ofXYctLJ\nEfkt7J8XWsWvesg1DV9S9IsO117j7xQkqXV8GRpScLu/U5AknfX/r4kky7p+/k4BTlxXUuTv\nFHQ+4Zf+TuEHLr4Ni8Vyd5Inp6VsKriplRdOzNgBAICAY7nUquszj1HYodkcd7zaa+X/KwMA\ngIlR2AEAgIDTwgcU2+ZEXE9/NDHMBQo7NBtzcgCAH7uWLOwsln9vabD/2bMw1zjuBAAA4Gpp\nUKLV19c7faOpiWFuMWMHAAACzo/itGEPUNgBAAA0lf1Emg/fTTKm6LxfiqWwAwAAAcdyycN3\n7K7ei+b2y69sngAAAPgRY8YOAADAEy183IlbTjdPeFDbUdgBAAD4xlV6A6/pKOwAAEDAuUq7\nYv1+1CuFHQAACDgtthTbxO2u7IoFAAD4EXCx3dW+gGNXLAAAgCc8Pu7EM40Vag36vV/JpbAD\nAMAkzif80t8pwM8o7AAAgC9dV1Lk7xTcM+ufFPuJvxMAAACAbzBjBwAAAk5rO6DYV5ixAwAA\nMAlm7AAAQOC5ZM537CjsAABAwGEpFgAAAK0aM3YAACDgMGMHAACAVo0ZOwAAEHA4oBgAAACt\nGjN2AAAg4Fgu8Y4dAAAAWjFm7AAAQMAx665YCjsAABBw2DwByGKxWCwWf2cBAACcY8YOAAAE\nHLMuxTJjBwAAYBIUdgGqoKAgOTnZYrFMmzatpKTE/lZlZeXSpUuNVdfk5OS1a9c29iE1NTU5\nOTlGZE5OTk1NTROH8MbW19aP6dR2TKe2W19b39yAx35375hObX2Sxgevr0+9ISz1hrAPXnee\nhmNAzckTJS/nGZ0lL+edq6v1Po1tr60f16XduC7ttjXybTgN+Hz/vqyZ6eO6tMuamf7NyRPe\np1H891diO4TEdggp/vsrzQ0oWL0qtkOI9zlIKnr1leERIcMjQopedZ6G0wC3TzXXuh01wRMO\nBE84sG5HjdOAD7/8bkbeseAJB2bkHauuvSipuvbiyq2njadWbj3tmzR2nQ2edjh42uF1u846\n3jVu2V/2d1e+V9egx0srv/4q6O23nOdZdTzo7beC3n5rXdVx152kYco0/Mhy6bIHl7+zdo+l\n2EC0du3a1NRU4+fs7Ozs7Ozi4uKEhARJFRUVUVFRtsiCgoKCggJJKSkpjp8zfvx4466ktLS0\n8vLyrKwst0N4Y8fmwkVpk5YVlkhKT0wIDgn92ZjEJgZ8vKt0x+ZNXiZgKC8qXD598vyCYklz\nk0YFh4YO+WWi24D31q99af4jy8v2S5oRPeDburqx1hnepFG2pXCJ9fdPbSqWNPPuUcGhodGj\nE90GnDh6JD1h+FObilNnPjJxQO8+A6NG/26SN2m8/+ameVMmZm/eKsk6Jj44JPTOu+5uSsDp\nEyc2r1vzbOZsb0a3ee/NTY9Nmfjclq2S0kbHtwkNHXFlGk4D3D7VXG/sqZuw4qt35vaSFDf/\ni9Cgn4wd3M4+4MipCzGPfvbO3F6Z/9mpxx8qB/cKnhwf8Y/yuukrj33515u/v1Df76GDtd9e\nTk+83qs0Pjw34fmT7/zpPyTFLT4eep1l7MArqufvsnoaPxysunDbvK9X3N/BaFbXXVqz8+ys\nV31TXEqqPn9+zfFjfz500HmeJ0+MP/DRu0OiJY0sLwu95pqxHTs57SQN86WBq4QZu0BklFxV\nVVX19fWffPKJpGXLlhm3srOzJW3fvr2+vr6+vv7w4cO2+AaMmi8/P9+IzM/Pz87Ots3MuRjC\nG5+Ul0m65faYW26PsTWbGFD0t5e9T8Dw6Z5dkvoNje43NNrWdBvw0vxHJHXs1r1jt+62pjcq\ny3dJihwaEzk0xtZ0G7Bna7HR2b5jpw1VdV5WdZI+Li+TNCA6ZkB0jK3ZlIDkyJ5nar7xcnSb\nA7vLJN0aHXNrdIyt6TbA7VPNVXboW0nD+oYM6xtia9or2nfGCOgc9tPvVvefHB8haXJ8xHer\n+3cO+2n366+VNCu/yts0vjgvaVjvoGG9g2xNp54prh17W5vJI36oPnvMPPrNOV/OSXR//91v\nLl5sNM/aWknDwsOHhYfbmk47ScN8afid5XK9B5e/s3aPwi4QJSUlSdqwYUNFRcXNN99cX1+/\nceNG41ZWVlZ9fX3v3r0rKioKCgpycnIa+5BNmzbJbibP+GHPnj1uh/DGmqefctF0EfDZ/n0D\nh8d6n4DhtWWLXTQbC5i6+BlJJ786cvKrI5JmrFjpZRrr/vKUi2ZjAaU+mra0eWHJky6aLgIe\nfHzRlDmP+SqNvCtHyXNIw2mA26ea64mNJ100Jb2xp87F41sPnJW0YnJXb9MorHHRtPnw6Pmc\nbWcmj/j3+wlP/DpiXnJ7L0e392SffvN692ns7qLDnzs2nXaShvnSwFVCYReIHn/88aSkpLS0\ntKioqGnTplVXV9vfzczM7NKlS1RUVHJy8oIFCxr7EGNuz2JHUkZGRlOGaHn/yMvtHz3Mvzkk\n3D/pFxMemBE9YEb0AElRo0b7JY2yLYV3TXzg9azl47q0ez1ruV9yMKQ8+Ec/ju4vb+w5MzUh\nYlnhqeAJB5YVnrK/NSPv2F1PHJ6aEGFM47WAnHfrJMX2C7b1pP8izLdDpPfo6dsP9Axp2Gsl\nafid5fJlDy5/Z+0ehV0gGjRo0MaNGw8fPmy1WrOzs6dMmVJZWWncysnJWbBggdVqLS4u3rt3\nb1WVh0tCLoZoeUcPHex2U5/ON3b3VwKG8qLCt1Y///S28ieK3pf0fzve91cmb77w/J1J96z4\noHzVvDlbXsrzVxoBK6fk9K9jwvY92WdWfpX9Vonlk7q+M7dXTslpX+2fcK267lLOtjOzEsPD\n2vAfAgSkS/WeXK0ev8+Bq0ePHllZWcXFxQUFBZGRkUZnWlqapKysrISEhEGDBgUFBTX2uNVq\nlVTvwO0QLW/n5sLBcT/31+g2xS/lSerap2/PAbdJWjzxv/yYTKcbu3fr00/Ssw97tYEDnul+\n/bX9ugZJmr7ymH2/8WZeg86r5MDXFyRF97quBcYC0GIo7AKRcQqJMYXWt29f/euVOBvjVk1N\nzZIlSxr7kLi4OEm2w1B27NhhsVgyMzObOESzGMeXjOnU9r7/nmnf36Dp2GM0n3tszrT4O2wH\nnXh84olxUknqDWG/Sv+TfX+DpmOP0SwvKvRs3AaM40vGdWl370NX/MM2aDr2GE3HMM8Yx5fE\ndgiZmPFn+/4GTccexwCfmHTlx05yGMVpgNunmmtWckcXTac9jsYO9vZQnlmJ4S6ahr1Hzksa\neKM/C7vZPW9ybDrtJI1AS6MFsBQL87jvvvskRUZGWiyWnj17Spo6dapxKz8/33arffv2Lt6x\nS0xMTEpKSk1NNV6wu+OOO+w/x8UQHth84oxxDRoRJ+njXaUf7yqVFDkk2ggwyj5JTgNsj9s+\nzbM08r+uNa4Bw0dKOri77ODuMkl9B99uBBhlnySnAcZuiYO7y44d+lRebJ7YUFVnXLeNGCnp\nk92ln+wulXTzkB/SMMo+SU4DbJ0njh6RlJG9yrM0tv3znHENHhEnaX9Z6f6yUkm3/OtfilH2\nSWoswLeGxsZJ+qis9KOyUkn9h/4winFGXWMBjT3lsfj+oZJ2fnpu56fnJEX3aWP0G2fU2Qcc\nOXVB0urp3SQZr9xV1140nvL+Hbv4yGBJOz/7fudn38tuWs7+yLpD1RckhftjHdY4Dk1SXESE\npJ01NTtraiRFh4U11kkaAZIGvMc5doHI2MG6Zs2agoKCpKSkqVOn2qbTUlJS6urqjAXZRx99\ndPz48Y0toYaHh+fm5m7YsME+uEePHm6H8EZUbFz6039NT0yQNPu5vAaH2DUlwCcGjIibuviZ\nuUmjJM1YsbLBIXaNBQy/5zeSbJ1G0xsDR8Q9uHT5zLtHScrIXtXgELvGAgaOiMvIXmXrjP2V\nt2kMHRk/c9mz1jHxkublvnCnwzlwbgN8YujI+Fn/+2za6HhJ/5P7guNxdE4D3D7VXPH9Q1dM\n7ho3/wtJq6d3a3CInRGweno3W8C9PwuXdN+d4ZJ6/KFy7OC2rz7U3fGpZqcRGbzi/g5xi49L\nWv1AxwaH2Blytp2R5N8X7H4e0SEr8paR5WWSXux/q3E0mtNO0gi0NFrAj2L6zQOWBi9FAX60\n5aSTI/Jb2D8vtIpf9ZBrLP5OQZI6XHuNv1OQpNbxZWhIwe3+TkGSdNb/vyaSLOv6+TsFtF7X\nlRT5OwU3LBbL7zt6cvbTqpN3t/LCiRk7AAAQcH4Upw17gHfsAAAATIIZOwAAEHAsl1rFizc+\nR2EHAAACjlk3T7AUCwAAYBLM2AEAgIDD5gkAAAC0aszYAQCAgMM7dgAAAGjVmLEDAAABx6zH\nnTBjBwAA4DcWiy//bCIzdgAAIOC0kl2xvq3qRGEHAAACUGvYPGGxWOrr631b27EUCwAA0NKM\nqs7nH8uMHQAACDh+X4q9GlWdKOwAAEAAWqEUzx60Xzm9SsWZN67KNCAAAACawrdrsrxjBwAA\nYBIsxQIAAFxFLbl6S2EHAABwFbXka28sxQIAAJgEhR0AAIBJsCsWAADAJJixAwAAMAkKOwAA\nAJOgsAMAADAJCjsAAACToLADAAAwCQo7AAAAk6CwAwAAMAkKOwAAAJOgsAMAADAJCjsAAACT\noLADAAAwCQo7AAAAk6CwAwAAMAkKOwAAAJOgsAMAADAJCjsAAACToLADAAAwCQo7AAAAk6Cw\nAwAAMAkKOwAAAJOgsAMAADAJCjsAAACToLADAAAwCQo7AAAAk6CwAwAAMAkKOwAAAJOgsAMA\nADAJCjsAAACToLADAAAwCQo7AAAAk6CwAwAAMAkKOwAAAJOgsAMAADAJCjsAAACToLADAAAw\nCQo7AAAAk6CwAwAAMAkKOwAAAJOgsAMAADAJCjsAAACToLADAAAwCQo7AAAAk6CwAwAAMAkK\nOwAAAJOgsAMAADAJCjsAAACToLADAAAwCQo7AAAAk6CwAwAAMAkKOwAAAJOgsAMAADAJCjsA\nAACToLADAAAwCQo7AAAAk6CwAwAAMAkKOwAAAJOgsAMAADAJCjsAAACToLADAAAwCQo7AAAA\nk6CwAwAAMAkKOwAAAJOgsAMAADAJCjsAAACToLADAAAwCQo7AAAAk6CwAwAAMAkKOwAAAJOg\nsAMAADAJCjsAAACToLADAAAwif8Hxn+7d5uWaPMAAAAASUVORK5CYII=",
      "text/plain": [
       "Plot with title \"\""
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "library(corrplot)\n",
    "library(dplyr)\n",
    "\n",
    "numeric_columns <- sales %>%\n",
    "  select(where(is.numeric)) %>%\n",
    "  select(where(~ sd(., na.rm = TRUE) > 0))\n",
    "\n",
    "cor_matrix <- cor(\n",
    "  numeric_columns,\n",
    "  use = \"complete.obs\"\n",
    ")\n",
    "\n",
    "jpeg(\n",
    "  \"Graphs/10_Correlation_Heatmap_Rainbow.jpeg\",\n",
    "  width = 2500,\n",
    "  height = 2500,\n",
    "  res = 300\n",
    ")\n",
    "\n",
    "corrplot(\n",
    "  cor_matrix,\n",
    "  method = \"color\",\n",
    "  order = \"hclust\",\n",
    "  col = colorRampPalette(c(\n",
    "    \"#6A00A8\",\n",
    "    \"#4361EE\",\n",
    "    \"#4CC9F0\",\n",
    "    \"#90E0EF\",\n",
    "    \"#FFFFFF\",\n",
    "    \"#F9C74F\",\n",
    "    \"#F8961E\",\n",
    "    \"#F94144\"\n",
    "  ))(300),\n",
    "  addCoef.col = \"black\",\n",
    "  number.cex = 0.65,\n",
    "  tl.col = \"black\",\n",
    "  tl.cex = 0.9,\n",
    "  tl.srt = 45,\n",
    "  diag = FALSE\n",
    ")\n",
    "\n",
    "dev.off()\n",
    "\n",
    "corrplot(\n",
    "  cor_matrix,\n",
    "  method = \"color\",\n",
    "  order = \"hclust\",\n",
    "  col = colorRampPalette(c(\n",
    "    \"#6A00A8\",\n",
    "    \"#4361EE\",\n",
    "    \"#4CC9F0\",\n",
    "    \"#90E0EF\",\n",
    "    \"#FFFFFF\",\n",
    "    \"#F9C74F\",\n",
    "    \"#F8961E\",\n",
    "    \"#F94144\"\n",
    "  ))(300),\n",
    "  addCoef.col = \"black\",\n",
    "  number.cex = 0.65,\n",
    "  tl.col = \"black\",\n",
    "  tl.cex = 0.9,\n",
    "  tl.srt = 45,\n",
    "  diag = FALSE\n",
    ")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a772a39a-d8b2-4d5e-96a9-164a91b73139",
   "metadata": {},
   "source": [
    "# WEEK 2: DATA VISUALIZATION AND INSIGHT COMMUNICATION USING R"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 32,
   "id": "a0f6ac01-6395-4802-b548-08443a0bc574",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: 'scales'\n",
      "\n",
      "\n",
      "The following object is masked from 'package:purrr':\n",
      "\n",
      "    discard\n",
      "\n",
      "\n",
      "The following object is masked from 'package:readr':\n",
      "\n",
      "    col_factor\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(ggplot2)\n",
    "library(dplyr)\n",
    "library(scales)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "id": "30948e12-3ca9-445f-9009-5049fce44bbb",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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\niQgiFCIQiQgiFCIQiQgiFCIQiQgiFCIQiQgiFCIQiQgiFCIQydLryoZRIGLZEYhkQSQi/CIQ\nyYJIRPhFIFL/CC5aJaIBIvWPQCQiGiBS/whEIqIBIvWPQCQiGiBS/4iaSO9++vjZ3vn88ad3\nAwO+fHh6ev9rcvfnd0/vPnyu3U2IH//4KV2EhD4hl/hezCYCkfpH1MZv/PCDvfNh+KbqnbXC\nOPIlufvuc+VuudbPUSFSL3Ev8b2YTQQi9Y9oiPRjMp7f/ThUpJ+fPryOPj79mNz9En15//RT\n5W5a66cv5va37GWfnn7tk3KJ78VsIhCpf0RDpGRs/xb/HSjSu6cvr01D9q4p+GLul+5mtezj\nD+njz/k9GZf4XswmApH6RzRE+vXpl/jvL0+fkic+/vj07qN96tNP8d5Xsiv2+afkXtZC/RDn\ndfz6n8uNNu+md+yGy/C+5xHZJb4Xs4lAJIvPLELxo6f38d/3T8lQf28VMSW/PGUHNbFP2eFN\n2kJdpP/3VPbo1+JBcTfbIqWv+vj0sUcPG70YheuNQCSLp0jv4yH+JXbHPPHx6b09svlknvm7\n2eN7Mvfiwo/nzg3835/elUx6/+5L8+7PpkLccpr+ru8pwoW8F8uMQCSLp0jxXl185P+LFel9\nut2wpwg+f/rlfSLS56iyv9YW8SHfxFgNG3eTs3iZSH+3+5N9WMh7scwIRPKOiAf2b/Fh/4en\nX6PEmWK37X12Lxn8paOdlmOkWL50G9PuUazlB3Oclb7qx6cvUT++9oq66AhE8o6woryz59hq\nIn14+vHjp89ikdLnP79/l53VLt3N+S3d1tmjML1e6HC9EYjkHZEo88mMb3O3tKWwYnxpEalO\ncvr7sz0f9+nd++wT2NLdtFZkjsHsoVT/PbuvvqIuOgKRvCOMHn+Pty4fo+xkw2dza736NT05\n4BDJfiD75SfTxG/Flua32kbnZ/O50a8/Jh/Ifuj3YayzFzpcbwQieUcYPeL9N3M6oXRgZC7s\n+TndgfvVJVJ68Y/x5kN5z7DYATQ3X4pLhMyG73NXY4N6ocP1RiCSd0R6QcK77G70849PT8ml\npvZS1E/xhsQlUvTz/4+Pp5I6uT1PNZHMyYan959KqYq90OF6IxCJCCIUIhCJCCIUIuYjUtCF\nXsRgiCDCwYxE+r2dSURiFiEi/CIQyYJIRPhFIJIFkYjwi0AkCWcvWh0jYhSIGDECkSQgEhEO\n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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 1: ENHANCED SALES DISTRIBUTION\n",
    "# =========================================================\n",
    "\n",
    "\n",
    "\n",
    "mean_sales <- mean(sales$sales, na.rm = TRUE)\n",
    "\n",
    "median_sales <- median(sales$sales, na.rm = TRUE)\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "plot1 <- ggplot(sales, aes(x = sales)) +\n",
    "\n",
    "  geom_histogram(\n",
    "    bins = 30,\n",
    "    fill = \"yellow\",\n",
    "    color = \"black\",\n",
    "    alpha = 0.9\n",
    "  ) +\n",
    "\n",
    "  geom_vline(\n",
    "    aes(xintercept = mean_sales),\n",
    "    color = \"red\",\n",
    "    linewidth = 1,\n",
    "    linetype = \"dashed\"\n",
    "  ) +\n",
    "\n",
    "  geom_vline(\n",
    "    aes(xintercept = median_sales),\n",
    "    color = \"darkgreen\",\n",
    "    linewidth = 1,\n",
    "    linetype = \"dotted\"\n",
    "  ) +\n",
    "\n",
    "  annotate(\n",
    "    \"text\",\n",
    "    x = mean_sales,\n",
    "    y = Inf,\n",
    "    label = paste(\"Mean =\", round(mean_sales, 2)),\n",
    "    color = \"red\",\n",
    "    vjust = 2,\n",
    "    hjust = -0.1,\n",
    "    size = 4\n",
    "  ) +\n",
    "\n",
    "  annotate(\n",
    "    \"text\",\n",
    "    x = median_sales,\n",
    "    y = Inf,\n",
    "    label = paste(\"Median =\", round(median_sales, 2)),\n",
    "    color = \"darkgreen\",\n",
    "    vjust = 4,\n",
    "    hjust = 1.1,\n",
    "    size = 4\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Distribution of Supermarket Sales\",\n",
    "    subtitle = \"Mean and median sales are shown as reference lines\",\n",
    "    x = \"Sales Amount\",\n",
    "    y = \"Number of Transactions\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot1\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/01_sales_distribution.png\",\n",
    "  plot = plot1,\n",
    "  width = 10,\n",
    "  height = 6,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 34,
   "id": "fa3dc267-b24b-49e5-beae-8106e906b2d8",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>product_line</th><th scope=col>total_sales</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Health and beauty     </td><td>49193.74</td></tr>\n",
       "\t<tr><td>Home and lifestyle    </td><td>53861.91</td></tr>\n",
       "\t<tr><td>Fashion accessories   </td><td>54305.89</td></tr>\n",
       "\t<tr><td>Electronic accessories</td><td>54337.53</td></tr>\n",
       "\t<tr><td>Sports and travel     </td><td>55122.83</td></tr>\n",
       "\t<tr><td>Food and beverages    </td><td>56144.84</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 2\n",
       "\\begin{tabular}{ll}\n",
       " product\\_line & total\\_sales\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Health and beauty      & 49193.74\\\\\n",
       "\t Home and lifestyle     & 53861.91\\\\\n",
       "\t Fashion accessories    & 54305.89\\\\\n",
       "\t Electronic accessories & 54337.53\\\\\n",
       "\t Sports and travel      & 55122.83\\\\\n",
       "\t Food and beverages     & 56144.84\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 2\n",
       "\n",
       "| product_line &lt;chr&gt; | total_sales &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| Health and beauty      | 49193.74 |\n",
       "| Home and lifestyle     | 53861.91 |\n",
       "| Fashion accessories    | 54305.89 |\n",
       "| Electronic accessories | 54337.53 |\n",
       "| Sports and travel      | 55122.83 |\n",
       "| Food and beverages     | 56144.84 |\n",
       "\n"
      ],
      "text/plain": [
       "  product_line           total_sales\n",
       "1 Health and beauty      49193.74   \n",
       "2 Home and lifestyle     53861.91   \n",
       "3 Fashion accessories    54305.89   \n",
       "4 Electronic accessories 54337.53   \n",
       "5 Sports and travel      55122.83   \n",
       "6 Food and beverages     56144.84   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAAOVBMVEUAAAAAi4tNTU1oaGh8\nfHyMjIyampqnp6eysrKzs7O9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD///8W7A4AAAAACXBI\nWXMAABJ0AAASdAHeZh94AAAgAElEQVR4nO2diWKq2KJEEU1M52SS///YlnmzAYcEqU256r0b\nDdOihNUMekxWEEL+nEy9AoQ4BJEIWSCIRMgCQSRCFggiEbJAEImQBYJIhCwQRCJkgSASIQsE\nkQhZIFsWKWtyeL8+5dyY0+v0ZPNz3IE/vWbZ/upyiEMcRDrvy1envGnM70Sax7/csGrEI9sW\nqX78zLMrx6T7RVoEn2Vf9yyQbDgOIhWf1/67/1CR5vH3LY9sOVve1P1+Wj7LstM+ezn/8vWa\nZ/lrcyz4OGT5WzM+mOk8OHs9NadnEwusn55/HPNs/1EN+TzPcviYxYcT1KuSdQsP1qhZy/Pw\nt3rJ7+eH+oB23J/n/yxibruqU6tAkomTSOdd93je8ZoLl2qHO1ZPX2OR6sH5dZEO3aL+1Us9\nzuHDCepV6UQK16hZyyx7qwZ9vlYPpUl5OFHP7VZ1ahVIMrEQ6aM8tzrvfeV/t7/O++ipOJ33\nv+/ql3/n0Xkk0leWfxSnQ7lLXrzZcN6BP4vTS7n0r+pg8XXIPsZTf8QTNKvSTDFYo2ZUVq7B\nWZK8ftgXxVv2VpQ/DzG3W9WJVSDJxEGksyjV3ludFh2b/2K/lo/H+jbAKR+K9FoNPpX77xWR\nPqrpsnJJlRqn6uRxCh9O0KxKM8VgjZpR3ZI/2un22WmKG6zqxCqQZLJtkdrU51PVwH353/1z\nvst9r9k7i5ehSO3g4qpIwSxtZvDhBO1E9eNgjbpFBoes9uHr4+0w5narOrEKJJlseaM0u1X+\n0v1nvQhkCPfow1CkufeLLoiUjffiGD8n0tQaTTy8593y51YVkdLNljfKcI+6JFK2gEi34QfP\n7xHp/Xz1dPz3fVGk0SqQZLLljTO5J0+dSJ2iXTi//9QuH7+3OsSHE9xyahc/7NuLp5jbrerE\nKpBkYifSMas/PVdd2r/U+957LVK5S37UV/D1xXx+u0iv9WK/gvdeh/hwgqFIgzWaFal++jHm\ndqs6sQokmdiJdD45OtY3m79Kg/J/9fsv5XXSy6m5E/6R5V/d7e/vyQXGO/RXdUvhK5+6/V0l\nnGAo0mCNLhyR3tsb9eHgYFUnVoEkEzuRhm/I1m9svpXjPusbbNVk9buc5X/Z95P34cYitYud\nfEM25AY3ENvH4Ruy4ZjhNVKdz+HYflUnVoEkEz+Rhh8R+td9RKj43HdPi/fz82qH/NrXnxpo\nFjEvUvF97D7MM4UPJ4hEGn5EqJh5eC+n+fyo34cKxnarOrEKJJlsWSRCkgkiEbJAEImQBYJI\nhCwQRCJkgSASIQsEkQhZIIhEyAJBJEIWCCIRskAQiZAFgkiELBBEImSBIBIhCwSRCFkgGxZp\n+lt13vNooksLWH6lInwE+hXxzplmJp9csZtGkltiJ1K0H60t0uQyUxDp4lL4gqI/Z+Ov4HgP\nQCREUmTjr2C3B3y/Ztnrd32YOv/6+ZLV/0C730Xe2n+mPRxX/lW9+o89vA3+Hff3Idt/DKfI\nsu+X5p99B8O+8kO/zAbfL/S8mJeBSC/Z4bv+CuKifRjM0K1d0cLOMx27f23eL6Njt9UDWA2s\nfjZLCQ/cXYtLa92U7xZewvbxapMuJiKdqq8pzU/NPtF/TUi3+9RfIvI+GlfNuA8nCBY4nOIM\naL98JBh2yF77ZcazVIt5CUR6qVfz2PyFi7dmRDdDv3b1Gry0M3XfeVL9cY1yGQ27qx7AepHa\npQQidQu+vNZZP3sHi1ebdDER6Vh+z07/5yX25R+h+Op3qaL+3q3P8otOhuPeuu/a7yaoUv5Z\niNMhnuJwKr/hazjsOOb1o4/dYpqVOC+hXM36y+lemi/bD2bol1R+Hd5nvcjzTG/dmnXLaNh9\n9R7WixQspX3NukGza92XD1/XYxGvNuljIlL1babhV5l+N19I3+0/efbafh9cOG5f73Ivgwn6\nBQ6mqL8Db2pYxOtH94tpVrddzeqrKzs5+hn6JXVfn99jm1+/uqrfg+o9rBcpWEpfrfvy1qtr\nHb6uJWy42qSPiUj9nlM/Owy+VqtM+d2L++/RuP7GXz9BvMDhsqaGRbypWaKlfp132I/stRve\nnUiO13x2GeGIeP2Gz8L5g2fX1zp+Nlxt0sdTpNds//7xPdiR6q+w+4zHBbtwO8FogddFing3\niFT+t/7YfWdqP8PEmj9MpBvWerSgwWqTPiYiRad21Y/TYEcq894N6cbtBy/Aezd5fGrXw+aG\nBbx+9Oyp3fm/68c8mGywvNPESVm8jO4rxmdP7b6vndrdsNajU+bBapM+G39R2t0jutlQfvHv\n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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 2: PRODUCT LINE PERFORMANCE\n",
    "# =========================================================\n",
    "\n",
    "# Calculate total sales by product line\n",
    "\n",
    "product_sales <- sales %>%\n",
    "\n",
    "  group_by(product_line) %>%\n",
    "\n",
    "  summarise(\n",
    "    total_sales = sum(sales, na.rm = TRUE),\n",
    "    .groups = \"drop\"\n",
    "  ) %>%\n",
    "\n",
    "  arrange(total_sales)\n",
    "\n",
    "\n",
    "# Display the summary table\n",
    "\n",
    "product_sales\n",
    "\n",
    "\n",
    "# Create the lollipop chart\n",
    "\n",
    "plot2 <- ggplot(\n",
    "  product_sales,\n",
    "  aes(\n",
    "    x = reorder(product_line, total_sales),\n",
    "    y = total_sales\n",
    "  )\n",
    ") +\n",
    "\n",
    "  geom_segment(\n",
    "    aes(\n",
    "      xend = product_line,\n",
    "      y = 0,\n",
    "      yend = total_sales\n",
    "    ),\n",
    "    linewidth = 1.2,\n",
    "    color = \"gray70\"\n",
    "  ) +\n",
    "\n",
    "  geom_point(\n",
    "    size = 6,\n",
    "    color = \"darkcyan\"\n",
    "  ) +\n",
    "\n",
    "  geom_text(\n",
    "    aes(\n",
    "      label = comma(round(total_sales, 0))\n",
    "    ),\n",
    "    hjust = -0.2,\n",
    "    size = 3.5\n",
    "  ) +\n",
    "\n",
    "  coord_flip() +\n",
    "\n",
    "  scale_y_continuous(\n",
    "    labels = comma,\n",
    "    expand = expansion(mult = c(0, 0.18))\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Product Line Performance\",\n",
    "    subtitle = \"Total sales generated by each product category\",\n",
    "    x = \"Product Line\",\n",
    "    y = \"Total Sales\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot2\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/02_product_line_lollipop.png\",\n",
    "  plot = plot2,\n",
    "  width = 11,\n",
    "  height = 7,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 35,
   "id": "fc6c2f57-535f-4d16-bb7c-784662677724",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 3 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>branch</th><th scope=col>total_sales</th><th scope=col>average_rating</th><th scope=col>transaction_count</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Alex </td><td>106200.4</td><td>7.027059</td><td>340</td></tr>\n",
       "\t<tr><td>Cairo</td><td>106197.7</td><td>6.818072</td><td>332</td></tr>\n",
       "\t<tr><td>Giza </td><td>110568.7</td><td>7.072866</td><td>328</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 3 × 4\n",
       "\\begin{tabular}{llll}\n",
       " branch & total\\_sales & average\\_rating & transaction\\_count\\\\\n",
       " <chr> & <dbl> & <dbl> & <int>\\\\\n",
       "\\hline\n",
       "\t Alex  & 106200.4 & 7.027059 & 340\\\\\n",
       "\t Cairo & 106197.7 & 6.818072 & 332\\\\\n",
       "\t Giza  & 110568.7 & 7.072866 & 328\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 3 × 4\n",
       "\n",
       "| branch &lt;chr&gt; | total_sales &lt;dbl&gt; | average_rating &lt;dbl&gt; | transaction_count &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| Alex  | 106200.4 | 7.027059 | 340 |\n",
       "| Cairo | 106197.7 | 6.818072 | 332 |\n",
       "| Giza  | 110568.7 | 7.072866 | 328 |\n",
       "\n"
      ],
      "text/plain": [
       "  branch total_sales average_rating transaction_count\n",
       "1 Alex   106200.4    7.027059       340              \n",
       "2 Cairo  106197.7    6.818072       332              \n",
       "3 Giza   110568.7    7.072866       328              "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nCAnLBpKLO7zKq8/IPUbupRlCwhJe8nLuWX9zc+fsIt+1q/f3slt+sydRJ6WVERKW8JJL0U5J\n0VQrpOyPRA/l9XvolQwCIWEJLzkO7M01Bxuuzt2yr4e0sOfBHYKtXUgICUt4ydARuvq2h3OX\n9CIu9v5eSo/m6VxrU4PPkuVTSN4zovq2uH0Yj5A2xdDgs2RZENLJxdXdXvfrMSKkTTE0+CxZ\nRiSH1nOkVki/LioP6N1jLzN16FxrU4PPkmX0qN3F+84P6RllBxoy7s7Fl98Hz5G2xdDgs2QZ\nfR0pejXf+SEd3LW8NS6LIqRNMTT4LFnevLOhfkX21wvpUr3zrg7oSkibYmjwWbK8ea+dO2ev\ntD5/4/Jtq1kwd+9Fozh70faVvbf1NbYQyRASlk0kl/rdQHGzC3f03iL0W1y5xDrf2kBIWLaR\nvH6zQ9vxuTy2kIfkvJCSe7rVOt7TrZTKd4cTEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZtEpEQEhZt\nEpEQEhZtEpEQEhZtEpEQEhZtEpEEDek/gGWEHJZBYIuERZtEJISERZtEJISERZtEJISERZtE\nJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtE\nJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtE\nJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtEJISERZtE\nJISERZtEJISERZtEJISERZtEJISERZtEJISEZSfJv5xgq7IxhIRlD0ma0E+OlZYICcv2kqqi\nqqWwK7UJhIRlc0krozylwKu1AYSEZWPJT68jCyUREpaNJQMdGSiJkLBsKxnsSH9JhIRlU8lI\nR+pLIiQsm0oISRaGBp8ly0fJaEfaSyIkLFtKCEkYhgafJcsmIbmapat5jfLFLJ19CELCsqHk\nTUc//34mSr4PKZ+TkDIMDT5Llm9CmrVv910F6zZULHL1JW6DocFnybJ5SM49okOS3I/ORef8\n++exuJZcIhdfsyv1xKScVmzM8kU8T86dniMzzoGQsGwoCRDSwZ2SW7GnlzcSldfO+U1pEM3E\nVz7t6IVU3BK9BmecBSFh2VASIKRsIxK73yR5FHUcXsnVRfkmJrlnV5qJ57S5e70xKm5JN2eH\nosDejLMgJCwbSlY52JDRhPTML5+3y6FI5FlOjdzpVt65mhi7lzd3cUt696eLR2acs0LzZxGB\nocFnybLZ60hNSPnFoTqKV3yffb2lu2rxc2Bi4oXU3H1oxlkrNHcGIRgafJYsO4V0cvH19mz3\nkO7OxS669ycmH0KqZ5wFIWHZUhImpPzrq9tDkj7ncf7E97t2vRlnQUhYNpWs9KbVbkj35HVo\nhxSltz2KgwfVxLM7V4ckkv7Bht6M81Zo5v2lYGjwWbLsFNLZ9Z8jFbdd/InP/Ah3vvmJ+oe/\nezPOW6GZ95eCocFnybLZH/Z1DjacnDvc2yEl58hFl9bE5HEoXn69ViH5L8j2Z5y1QnNnEIKh\nwWfJwp+aa8PQ4LNk4eQn2jA0+CxZOB2XNgwNPksWThCpDUODz5JlsoRTFgvB0OCzZJkj4ST6\nEjA0+CxZtvlRJEJIWLRJREJIWLRJREJIWLRJREJIWLRJREJIWLRJREJIWLRJREJIWLRJREJI\nWLRJREJIWLRJREJIWLRJppK9n28zGSFh0SaZQP42vvI9sdvUREhYtEk+8e9f5w+etmiJkLBo\nk3xg+KQQoa2EhEWb5C3drVG9VQqcEiFh0SZ5x7uTiwcVExIWbZJxhs6rstGZIQgJizbJOG87\n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\nh8RRu/0tcf3y0CP/DZg/NNUDc88vL+6U/79cYpagIb0iF9/SvYTnb5wHEmdhvc4Duw68jrS7\nxd8ZyLdD+UOTPjDHZ3JPH7NnFli2NYrf7NwRUhie1cGFYkPzW14vHorWPnj5zgbHOxv2spy9\nf/tb9huveGj8BybOjx493uzcEVIobtnB7vhcHr67H5w73sv9hPaT2eK9dhO3R1IGnyVLK4/I\ntd5r507Zb77qvXZvdu4ISRsyBh+WPSQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQi\nISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQi\nISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQi\nISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQiISQs2iQi\nISQs2iQiISQs2iQiISQs2iQiISQs2iQiCRrSfwDLCDksg8AWCYs2iUgICYs2iUgICYs2iUgI\nCYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgI\nCYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgI\nCYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgI\nCYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgI\nCYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgI\nCYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgICYs2iUgI\nCYs2iUgICYs2iUgICYs2iUgICYs2iUgICcsYPz//cn5+fsJJrEBIWIb4KQKqyL5ZX2IJQsLS\nox2RF9OaEmMQEpYOgxWVLX1KiZC0IWzw2bG8yWhCSoSkDVGDz5DlfUY530ssQkhYGj5sjj5v\nlAhpO8qDqh9+tX1CzuAzZJmS0fuNEiFtROt40JTDQGOIGXyGLJM7Gi+JkDahv+ewOCUpg8+Q\nZUZHoyUR0gYM74AvTEnI4DNkmdXRWEmEFJ7xB2rJ0mQMPkOWmR2NPGqEFJp3x4OWbJREDD5D\nltkdDZdESIH59DjNXqCEwWfIsqCjwQeNkILy+eWJ2RslAYPPkoWQvmWbkJY9Ku8QMPgMWRZ1\nNPSYEVJIpj1M85a5/+AzZFnY0cBjRkgBmfowzVro7oPPkoWQvoeQsCzuqP+YEVI4pj9Mc5a6\n9+CzZCGkFQge0pxHacZi9x58hixfdNR7yAgpGIQk3UJIaxA6pHmP0vTl/okhvo2FkNaAkP66\n5ZuMfpLOQ0ZIgZj7227ygv/CEN/G8tUGqfuIEVIgCEm8hZBWgZD+uoWQViFsSLMfFWHnxv0D\nlu8y6j5ihBQGQhJvIaR1CBvS/N2GqUv+A0N8G8uXe3Y/hFRASH/cQkjrQEh/3EJI60BIf9xC\nSOtASH/cQkjrwFG7P24hpHUgpD9u+TYjQiogpD9uIaR14C1Cf9xCSOtASH/dwnvtViFwSDMf\nFELa3kJIq8Af9v11y3cZEVJJ6JC+eVTe8ReG+DYWQloFTn7y5y2cs2ENgoc04zEhpF0shLQG\n4U8QGaSjvQefJcs3GRFSBacsxsKZVldgg5AmPiSEtJdleUaEVLPFx7oE6Gj3wWfKwqdRfA8f\nNIZl6SZp4JcfIQVlwkNCSHta1uqIkEIz/yH5wP6Dz5SFz5D9lkkhRcXXFP9y6DZ/Wou3Gc3v\nSMLgs2RZkhEh+UwJqWyk/NJ807/Nn9Zl1gPyEQGDz5RlnY4I6R1RskpIw4/Vos1RImPwmbKs\n0hEhvacfUmfCpJAGHqylGQkZfKYsa3RESO/phNQ8D/oQ0n89/ve//+VfsoviG5DC/6bzX/AH\nbr0RvhELQoqSZbt2Jd6vtS+Q8VvcluXr7RFbpA+s8xxpVaQMPlOWrzsipPcQ0h+xTMvoza4E\nIb2FkP6M5ZvN0WSJRQgJS4svNkfTJQb54p0N0dBtY+9sWBtRg8+WZXlGhLSIbYoZQdjgs2Up\nmulElN+6osQYhIRliLqdIp+fKRXNllhio3d/r47EwWfN0toehZJYQWtIAKIgJIAVICSAFSAk\ngBUgJIAVICSAFSAkgBUgJIAVICSAFSAkgBUgpCGGTt2nlCjyfgDlP4tkCGmAoT+5Uo2ln0Uo\nhDSAtZC6J32C9SGkAYZO3acZQgoPIQ0wdOo+xUStK7p/FrEQ0gDdU/cpf4ZOSBtASAO0Bly2\ncdI9+AhpAwhpgN6AUz34ovY11T+LXAhpAFtH7QhpCwhpAEKCuRDSEEOn7lNL66iJ8p9FLoQE\nsAKEBLAChASwAoQEsAKEBLAChASwAoQEsAKENIhzq/zDXA/OHX7HJs5+SceVHO/9Ba2zwrAU\n/vmHuKWj9fb1Up5RMe4Pw5PnD31Xc2/fvGhpsCb88w9xckd3+nopkTs90ygjdx2cvCSk/OJ1\ndvF3C4LV4TEYwrlXNjpf5YCN3SN5nZw7vfJpjyjdxtyPzkXnbOrz4OJbPpjr++T8umN+eXNR\nNdjzr5fIxddi85LNnc3zLKYd0zmesTu+/GWVvnr2+kq1BsWCiv+fx95KwSbwTz3ALd0cnbJ9\nu6PLhvgz6ynfTcu6SnfV0sm3YhcrHbSvcgcu8e6Tc6x2wB6JH9I5v/e1HP/F3NErm5aG4X7j\n9Msp6fmSJOlskeo18EOK+isFm8A/9QBZRFlM6Zfs1/s5/faSXTu7fEuS3Ra737SQbKRe0udA\nr0NxrbpPTmsYNyGlm43kXm+kztkzqIPLNyyndCOWXvttL6vwlQvxniM1a1A/R0qbeyXXbNnN\nSsE28E89QPPsPa7+0jwuQjgWIWQ8b5d8pMbZ98/iWnWfZimtReZf02dOt+amcu64XG66T1lM\n6PuSJqTTo7UGXkjlPqK3UrAN/FP3KXeasn27a/q7/+4uzRiu+zi0vy+utfanRkK6pXtdcTXg\nW3MnrSY6vnoht+ooYHsNuqvSWwMICv/UfU7VL/7scMMp3cF69Qf2ycXX2/NtSPVzpOTeHtmP\n2EX3xSEVe4O9NSCkfeGfuk/k8sNm2XONdLg+8321uP6H8sboa2jXrqY6anePTuX9632taz3Y\n/V27xPvS9flX42wT6a3BQEjs2m0N/9Q97uVBslO2RbmXr36es6f8v9m2oBqt9/LZfHm4wPn3\nKahfR3pk13/L+0fpnI/Bgw2J96XrS5Kkvvpw2RKbNRgIqVkp2Ab+qXucy12yW3l4Lj+eXR5P\nfjT7V9WuV3OkublPwTOuj5EX9780h7/zp11R+/B34n3p+nKqq5dsnZo1cFWWTUgc/t4a/ql7\neJ/dkGR7YcV75bIXTg9ZYeXozL8tdtgOLv4trlX3qbidouq9ducojafYCEUuuuRLjpL2C7L+\nl64v8a/mO3f1Glz7IXkrBZvAP/U6OIknFRG5UkYhpG/Jn0OdV3hr3pqIXCnTENK3lM9Vnp/v\nuSEiV8o0hPQ117h8liMJkStlGUICWAFCAlgBQgJYAUICWAFCAlgBQgJYAUICWAFCAliB/wNh\nT9JtbVbVwAAAAABJRU5ErkJggg==",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 3: BRANCH PERFORMANCE BUBBLE CHART\n",
    "# =========================================================\n",
    "\n",
    "# Calculate branch-level performance\n",
    "\n",
    "branch_performance <- sales %>%\n",
    "\n",
    "  group_by(branch) %>%\n",
    "\n",
    "  summarise(\n",
    "    total_sales = sum(sales, na.rm = TRUE),\n",
    "    average_rating = mean(rating, na.rm = TRUE),\n",
    "    transaction_count = n(),\n",
    "    .groups = \"drop\"\n",
    "  )\n",
    "\n",
    "\n",
    "# Display the summary table\n",
    "\n",
    "branch_performance\n",
    "\n",
    "\n",
    "# Create the bubble chart\n",
    "\n",
    "plot3 <- ggplot(\n",
    "  branch_performance,\n",
    "  aes(\n",
    "    x = average_rating,\n",
    "    y = total_sales,\n",
    "    size = transaction_count,\n",
    "    label = branch\n",
    "  )\n",
    ") +\n",
    "\n",
    "  geom_point(\n",
    "    alpha = 0.7,\n",
    "    color = \"mediumpurple\"\n",
    "  ) +\n",
    "\n",
    "  geom_text(\n",
    "    nudge_y = 1200,\n",
    "    size = 5\n",
    "  ) +\n",
    "\n",
    "  scale_size_continuous(\n",
    "    range = c(8, 18)\n",
    "  ) +\n",
    "\n",
    "  scale_y_continuous(\n",
    "    labels = comma\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Branch Performance Overview\",\n",
    "    subtitle = \"Bubble size represents the number of transactions\",\n",
    "    x = \"Average Customer Rating\",\n",
    "    y = \"Total Sales\",\n",
    "    size = \"Transactions\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot3\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/03_branch_performance_bubble.png\",\n",
    "  plot = plot3,\n",
    "  width = 10,\n",
    "  height = 7,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 36,
   "id": "7ede495a-271e-469f-a6b0-a8e3f6b52384",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Saturday'</li><li>'Friday'</li><li>'Sunday'</li><li>'Monday'</li><li>'Thursday'</li><li>'Wednesday'</li><li>'Tuesday'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Saturday'\n",
       "\\item 'Friday'\n",
       "\\item 'Sunday'\n",
       "\\item 'Monday'\n",
       "\\item 'Thursday'\n",
       "\\item 'Wednesday'\n",
       "\\item 'Tuesday'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Saturday'\n",
       "2. 'Friday'\n",
       "3. 'Sunday'\n",
       "4. 'Monday'\n",
       "5. 'Thursday'\n",
       "6. 'Wednesday'\n",
       "7. 'Tuesday'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"Saturday\"  \"Friday\"    \"Sunday\"    \"Monday\"    \"Thursday\"  \"Wednesday\"\n",
       "[7] \"Tuesday\"  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>13</li><li>10</li><li>20</li><li>18</li><li>14</li><li>11</li><li>17</li><li>16</li><li>19</li><li>15</li><li>12</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 13\n",
       "\\item 10\n",
       "\\item 20\n",
       "\\item 18\n",
       "\\item 14\n",
       "\\item 11\n",
       "\\item 17\n",
       "\\item 16\n",
       "\\item 19\n",
       "\\item 15\n",
       "\\item 12\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 13\n",
       "2. 10\n",
       "3. 20\n",
       "4. 18\n",
       "5. 14\n",
       "6. 11\n",
       "7. 17\n",
       "8. 16\n",
       "9. 19\n",
       "10. 15\n",
       "11. 12\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] 13 10 20 18 14 11 17 16 19 15 12"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAACWFBMVEUAAABNTU1oaGh8fHyL\nAACMAwKMjIyNBwOODAWPEAaQEwiRFgmSGQuTGwyUHg6VIA+WIhGYJROZJxSaKRWampqbKxec\nLRidLxmeMRufMhygNB2hNh+iOCCjOSGkPCOlPiWmPyanQSinp6eoQympRCqqRiyrSC2sSS6s\nSzCtTDGuTjKwUDSxUjaxUzeyVTmysrKzVzq0WDu1Wj22Wz63XT+4XkG4YEK5YEK5YUS6YkS7\nZEa8ZUe9Z0m9aEq9vb2+aku/a03AbU7Bb1DCcFHCclPDc1TEdVXFd1jGeFnHelrHx8fIfFzI\nfV3JfV3Jf1/KgGDLgmLMg2PNhWXNhmbOiGjPimrQjGvQjGzQ0NDRjW3Sj27SkHDTknHUk3PU\nlHPVlXTVlnXVlnbWlnbWmHfXmXjXmXnYm3rYnHzZnX3Znn3Z2dnan37an3/aoIDbooHco4Lc\no4PcpYTdp4beqIffqonfq4rgrYzgro3hro7hsI/h4eHisZDispHjs5LjtJPktZTktZXkt5bl\nuJjluZjmupnmu5vnvJvnvZzov57owJ/owKDpwaDpwqHpwqLpw6Lp6enqxKTrxqXrxqbrx6fr\n6+vsyKjsyajtyqrtzKvtzKzuzq3uz6/v0bDv0bHw0rLw07Pw1LTw8PDx1bTx1bXy17fy2Ljy\n2bnz2rrz27vz3Lvz3bz03r7037/14MD14cH14sL248P25cX35sb36Mj46cn46cr57Mz57c75\n7s767s/678/68dH78tP79NT89db89tf899j9+dn9+tv++9z+/N3//d7//+D///+QI0ZnAAAA\nCXBIWXMAABJ0AAASdAHeZh94AAAgAElEQVR4nO3dB5vrzEGGYY0dTO+md9PrAqEGWHpbekIx\nPbQApiV0TEvo3QE+ekmcEHpNqKHX+VuoazQajy35ta3VPs91nXXRSNaenftY1u7xJpaIzi65\n9Q4QTSEgEQkCEpEgIBEJAhKRICARCQISkSAgEQkCEpEgIBEJuhmk9dIkyWy19+9Pju6RP2K/\nPO0R8/UODI4/alJkltvTHunYTvhXj3/ONPZu9SVclJMzWXsL+kM6dRrm4w4MPglS2uq0hzqy\nE/5VID3+bvQlvE9MJmh3nyTev/KXgxQbfAxSfpHt7V2PxzryQECaUjf6EppkV1y5T7xjrRFD\n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\nICABCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCgAQkIAkC\nEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKSoPH8BdBjbjzzaHSQvqtf9qt6Zn+pX/an\nema/sWf22f2yP9sz+yc9s//YL/usntlf69eAeXTtgAQkIAkCEpCAJAhIQAKSICABCUiCgAQk\nIAkCEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKS\nICABCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCgAQkIAkC\nEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKSICAB\nCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCgAQkIAkCEpCAJAhIQAKSICABCUiCBkEyVUeGHV4E\nJCABKe8IoiNDgAQkIOUBCUhAajoTkqk+VAd6zqVzvzO4CEhAAlJeG1Lo0jS3PUjPHA5IQApA\nikyYkXQJSM791rnfPdLjGQlIPCPleZCqk3jGO+Rzju2ABCQgdQo8I5ULjHO/86d16gFIQAJS\n3kFIwddMQAISkII1kEwAjnu/ARKQgHSo0kX7NHfw9Hf7zEMRkIAEpEEBCUhAEgQkIAHp7Pyf\nbwUSkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIg\nIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQIS\nkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJ\nSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQISkIAk\naDx/AfSYG888Gh2kj+iX/b6e2b/tl31Nz+yX9Mz+YL/sD/TM/njP7B/1y76iZ/a7+zVgHl07\nIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQIS\nkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJSIKABCQgCQISkIAkCEhAApIgIAEJ\n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\nSEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAE\nJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEAC\nkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJ\nOgeS8S4PLQ8EJCABqcoY9yKw/PCqQAISkKqABCQglZ13aGeaj8aUNwpX2UVzfymuWRVIQAJS\nlQOpwFM+O5W3TXO/B+mZwwEJSAFIkQkzktSQvEvr3HaP9HhGAhLPSFWmUXQYUnNsByQgASnU\nKZCaP61TD0ACEpCqToDkgAISkIAUzHnGCQEyziWQgASkQ7UO3arT383t1qX3TSUgAQlIgwIS\nkIAkCEhAAtLZ+T9GBCQgAUkQkIAEJEFAAhKQBAEJSEASBCQgAUkQkIAEJEFAAhKQBAEJSEAS\nBCQgAUkQkIAEJEFAAhKQBAEJSEASBCQgAUkQkIAEJEFAAhKQBAEJSEASBCQgAUkQkIAEJEFA\nAhKQBAEJSEASBCQgAUkQkIAEJEFAAhKQBAEJSEASBCQgAUkQkIAEJEFAAhKQBAEJSEASBCQg\nAUkQkIAEJEFAAhKQBAEJSEASBCQgAUkQkIAEJEFAAhKQBAEJSEASBCQgAUkQkIAEJEFAAhKQ\nBAEJSEASBCQgAUnQeP4C6DE3nnk0OkjP65d9dc/sv/fLfnTP7PN7Zl/aL/uqntn/61nfpzD7\nJT2zL+nXgHl07Z/DAvAAAAXcSURBVIAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQI\nSEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAE\nJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEAC\nkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgoAEJCAJ\nAhKQgCQISEACkiAgAQlIgoAEJCAJAhKQgCQISEACkiAgAQlIgjSQTFF1y7sMBCQgAalbmAyQ\ngASkXgEJSEASZJor6QFedss0l6Za7sACEpCA1K2BZIpbprxuiqUepGcOByQgBSBFJsxIUp5s\nsDWc+tI6t90jPZ6RgMQzUjfTutKC1BzbAQlIQIp3GFLzp3XqAUhAAlK3g5AcUEACEpCOFIRk\nnEsgAQlIx+tAck9/t888FAEJSEAaFJCABCRBQAISkM7OtB0BCUhAUgQkIAFJEJCABCRBQAIS\nkAQBCUhAEgQkIAFJEJCABCRBQAISkAQBCUhAEgQkIAFJEJCABCRBQAISkAQBCUhAEgQkIAFJ\nEJCABCRBQAISkAQBCUhAEgQkIAFJEJCABCRBQAISkAQBCUhAEgQkIAFJEJCABCRBQAISkAQB\nCUhAEgQkIAFJEJCABCRBQAISkAQBCUhAEgQkIAFJEJCABCRBQAISkAQBCUhAEgQkIAFJEJCA\nBCRBQAISkAQBCUhAEgQkIAFJEJCABCRBQAISkAQBCUhAEjSevwB6zI1nHj12SGyIDY0iILEh\nNiQISGyIDQkCEhtiQ4KAxIbYkCAgsSE2JAhIbIgNCQISG2JDgoDEhtiQoBtBIppWQCISBCQi\nQUAiEgQkIkFAIhIEJCJBQCISBCQiQUAiEnQTSCbtFo97qGJnxrRXzR6NZZfG9nfU7Mk4dugW\nkEz9YRyZZodGslflHBnJ3mSN7e/I2Z1R7A+Qsj0Z2SSp9mgke5M1ur+jek/MOPYHSFkmcO22\nje6vaGyQ8sb0zw2Q7HghjecVCZCOdStI45kh1vlSjGanxjdtx3aywdZ/NePYoVudtRvJp180\nUkjetds2PtpAyhvHp19kvMvbB6TjjeurxmskO7J/2vJGOm3HtEcjO4wAkh3Xi9Yi5+zuSBob\npLE9Z/OTDdY9RzaW3RrfS/uR7ZHz1RrHDvGzdkSCgEQkCEhEgoBEJAhIRIKARCQISESCgHTB\nksS/ckq7eZLM8mv3JrZukmdWuzP2kFQB6YINg2QyH81qRyClrc/YRRIFpAs2DFIz+Bik7ONu\nmZj9sN0jYUC6YG1I6ZRPlrv67uxjkmzNvBxTLU6cJ6RijF2lB3DZHftsyN7f+jK5Sz9uFtlh\nnt0XR4XlBV0tIF2wFqR9fsiWPXu4kObJshhSL+5CWmRXMkn5kJm/9W2SWlwXR3mrFF12pPeQ\n46LrBaQLljTZdIan832egXAhraqx/uJqSIZtb+8SY9MPq2zcvbu0ujJLHjJSScHKLpLNtT5J\nygPSBWtBmiXpcdsue0JxIdWn3PzF1ZByTLGF/M6Fu7S5slvfzbNri2Sb3jWOH4l+QgHpgrWm\nusunfc0Z277TOdlQLKhQdreePpmVy7aptHV1wEjXCkgX7DqQNtlz1DKZ3a93+V3pc9uKU+LX\nDkgXzHsV0zp223mQIod2zRaCW19kr5ryG/v84zpZGb6s146/8QvWgtScTTDJg93PPUiRkw3N\nFlbZ+bh5a+vZ95HyG5tymxm4egxdKyBdsAOnv1fZlTsPkn92vFjNuJCKIdm5hHJpWXaCbuUc\n9q2T7BQeXTUgXbAD35C16aHXnf8ayf9+bdZ9G1I+ZL5ptp5/W2lVfIc2X1R/A4qfv7t2QJpe\nG36s4foBaXrNOWd3/YA0tRJONdwiIE0tU//oA10xIBEJAhKRICARCQISkSAgEQkCEpEgIBEJ\nAhKRoP8HLI7pilUEEQoAAAAASUVORK5CYII=",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 4: DAY-HOUR SALES HEATMAP\n",
    "# =========================================================\n",
    "\n",
    "# Check the values before creating the graph\n",
    "\n",
    "unique(sales$day)\n",
    "\n",
    "unique(sales$hour)\n",
    "\n",
    "\n",
    "# Calculate total sales by day and hour\n",
    "\n",
    "day_hour_sales <- sales %>%\n",
    "\n",
    "  group_by(day, hour) %>%\n",
    "\n",
    "  summarise(\n",
    "    total_sales = sum(sales, na.rm = TRUE),\n",
    "    .groups = \"drop\"\n",
    "  )\n",
    "\n",
    "\n",
    "# Create the heatmap\n",
    "\n",
    "plot4 <- ggplot(\n",
    "  day_hour_sales,\n",
    "  aes(\n",
    "    x = hour,\n",
    "    y = day,\n",
    "    fill = total_sales\n",
    "  )\n",
    ") +\n",
    "\n",
    "  geom_tile(\n",
    "    color = \"white\",\n",
    "    linewidth = 0.4\n",
    "  ) +\n",
    "\n",
    "  scale_fill_gradient(\n",
    "    low = \"lightyellow\",\n",
    "    high = \"darkred\",\n",
    "    labels = comma\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Sales Intensity by Day and Hour\",\n",
    "    subtitle = \"Darker areas represent higher total sales\",\n",
    "    x = \"Hour of the Day\",\n",
    "    y = \"Day\",\n",
    "    fill = \"Total Sales\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot4\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/04_day_hour_sales_heatmap.png\",\n",
    "  plot = plot4,\n",
    "  width = 11,\n",
    "  height = 7,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 37,
   "id": "d91f6b6a-146f-4acf-9114-539e05aae0a7",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 3 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>month</th><th scope=col>total_sales</th></tr>\n",
       "\t<tr><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Jan</td><td>116291.87</td></tr>\n",
       "\t<tr><td>Feb</td><td> 97219.37</td></tr>\n",
       "\t<tr><td>Mar</td><td>109455.51</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 3 × 2\n",
       "\\begin{tabular}{ll}\n",
       " month & total\\_sales\\\\\n",
       " <ord> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Jan & 116291.87\\\\\n",
       "\t Feb &  97219.37\\\\\n",
       "\t Mar & 109455.51\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 3 × 2\n",
       "\n",
       "| month &lt;ord&gt; | total_sales &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| Jan | 116291.87 |\n",
       "| Feb |  97219.37 |\n",
       "| Mar | 109455.51 |\n",
       "\n"
      ],
      "text/plain": [
       "  month total_sales\n",
       "1 Jan   116291.87  \n",
       "2 Feb    97219.37  \n",
       "3 Mar   109455.51  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\ngg==",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 5: MONTHLY SALES TREND\n",
    "# =========================================================\n",
    "\n",
    "# Calculate total sales by month\n",
    "\n",
    "monthly_sales <- sales %>%\n",
    "\n",
    "  group_by(month) %>%\n",
    "\n",
    "  summarise(\n",
    "    total_sales = sum(sales, na.rm = TRUE),\n",
    "    .groups = \"drop\"\n",
    "  )\n",
    "\n",
    "\n",
    "# Display the summary table\n",
    "\n",
    "monthly_sales\n",
    "\n",
    "\n",
    "# Create the line chart\n",
    "\n",
    "plot5 <- ggplot(\n",
    "  monthly_sales,\n",
    "  aes(\n",
    "    x = month,\n",
    "    y = total_sales,\n",
    "    group = 1\n",
    "  )\n",
    ") +\n",
    "\n",
    "  geom_line(\n",
    "    color = \"firebrick\",\n",
    "    linewidth = 1.2\n",
    "  ) +\n",
    "\n",
    "  geom_point(\n",
    "    color = \"firebrick\",\n",
    "    size = 4\n",
    "  ) +\n",
    "\n",
    "  geom_text(\n",
    "    aes(\n",
    "      label = comma(round(total_sales, 0))\n",
    "    ),\n",
    "    vjust = -1,\n",
    "    size = 3.5\n",
    "  ) +\n",
    "\n",
    "  scale_y_continuous(\n",
    "    labels = comma,\n",
    "    expand = expansion(mult = c(0.05, 0.15))\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Monthly Sales Trend\",\n",
    "    subtitle = \"Changes in total sales across the available months\",\n",
    "    x = \"Month\",\n",
    "    y = \"Total Sales\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot5\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/05_monthly_sales_trend.png\",\n",
    "  plot = plot5,\n",
    "  width = 10,\n",
    "  height = 6,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 38,
   "id": "235957cc-8567-4438-9298-8f6a17e1a36e",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>product_line</th><th scope=col>average_rating</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Home and lifestyle    </td><td>6.837500</td></tr>\n",
       "\t<tr><td>Sports and travel     </td><td>6.916265</td></tr>\n",
       "\t<tr><td>Electronic accessories</td><td>6.924706</td></tr>\n",
       "\t<tr><td>Health and beauty     </td><td>7.003289</td></tr>\n",
       "\t<tr><td>Fashion accessories   </td><td>7.029213</td></tr>\n",
       "\t<tr><td>Food and beverages    </td><td>7.113218</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 2\n",
       "\\begin{tabular}{ll}\n",
       " product\\_line & average\\_rating\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Home and lifestyle     & 6.837500\\\\\n",
       "\t Sports and travel      & 6.916265\\\\\n",
       "\t Electronic accessories & 6.924706\\\\\n",
       "\t Health and beauty      & 7.003289\\\\\n",
       "\t Fashion accessories    & 7.029213\\\\\n",
       "\t Food and beverages     & 7.113218\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 2\n",
       "\n",
       "| product_line &lt;chr&gt; | average_rating &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| Home and lifestyle     | 6.837500 |\n",
       "| Sports and travel      | 6.916265 |\n",
       "| Electronic accessories | 6.924706 |\n",
       "| Health and beauty      | 7.003289 |\n",
       "| Fashion accessories    | 7.029213 |\n",
       "| Food and beverages     | 7.113218 |\n",
       "\n"
      ],
      "text/plain": [
       "  product_line           average_rating\n",
       "1 Home and lifestyle     6.837500      \n",
       "2 Sports and travel      6.916265      \n",
       "3 Electronic accessories 6.924706      \n",
       "4 Health and beauty      7.003289      \n",
       "5 Fashion accessories    7.029213      \n",
       "6 Food and beverages     7.113218      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nRc1QBImiZqh1B8n1//HQzHWYfMOBQ+/eJcMK/3Rwc3/Dd77zK6vffIPT3/0b1aqDNNMfPrle\n03Ma/9O38fLuoR8H8wTpZivvcruFWWrVfZW4Xf9vRMxbMwXpGfsgSFq16r5yrriFVH2rkI07\nF38wr/qrDedwj67TzlX/XDofQm3K2/o065R12ZVrRLf4+Sj/vXR1rriE9av7MezcLrtswh1C\nssG+suFu23+R7Vy9n8gkq/7hdmcfTVuRaPQ2Wtt99VJWq22jBpoGw+520Q2Vyre0i/S63dBz\njyRa747tpuz+9F3u8j1eaw7SMT8dFfeM2lV3CtpUA6X8MQt/IyGJbsaRtrc+bdYpqgS7+Dgr\n7/pxqA6lcgVf/HmTcCPwz3ArkCQb7CvLhruNg+SHJlkdpHgfTVvtDvpvY1e7NDfjKv6YRNRA\n22CxtOsGqW4lClLTcM+9lWi9e7b76g9RvMmtIMdrzUEKIQphyr+E4yl8Pz+am8KXx1hxT6hz\n+OaHvwyRbsul9sbxWXmLt1P3OAt3nzo1tynZhxvpVHelSsJdq/bhSzbYV1Zu3t1tc41U/BmI\nQ2i0NcnqHXb20bTV7qBtL7LN2/to7klSPI0aaBvcN7uLf1J03nOnG3rurUTr3bMtb2O3c+/y\np5BGa81Bai/kN+F4Cnfb2ZTHSnM/u/w8Vd3Lvri36KVcqtcpqrmFeHuc+frGRGXj5Zabqs3i\nForddqLbvvV3GwWpvllXa3J1H7VZK9q+jTTeUdTKudNA22C7u/YN9t5zpxt67q1E3INd2+IO\nk+9yS9UrteIgRbdmO+Q/DU/lnb47d4qqb9nWO9/EQ6ustxC+hhskbprjNN4y60Sjt6+ote5u\n+/sf7rZPK9KIbge7Gmtl0Py1HQ/ffLTUdx/rwe7SOc/Z8bnTPvK14iAl1bc4CRe6Sfm3efrf\n9sRtDsdL/5v/U5DKG7mdHg9Sb7eTg9R/G9l4K7MEaeD+c5DCKWr/Ln+a70qtOEjlTd7LPySU\nuEsxBNr0Dozia9odUG2677k7zGmGXIdocNMOZLLoS39fo7sdCdJPQ7vIrNNq9TYGA9HqadFA\nc3/yq0O7y0grw25Io3ffrjE2tCtQfpHqV3wkzVHrffun5j7wp/L+uOXdgfed+92HVzsXyC5e\np6jwtLi2DvfkL9f1+Vbn0cmGLPrS31eWZcPdjgSpNWm36O2jNat30L6NfTQTEAepmAlo/o5N\n2+BHOQ3ReYO9Vjrd0HNvJeIe7NtuXHTf/Les9QZpX80SHat5sk14Uk3RntvjqTtlGy3Vf4Dk\nUs/vFut+lAdKsRga8d3J3iz60t9XUf3dujqP7YHfnf6uzgDdfZTV7qBtr7EdBsnFf0tpbPq7\nfYNRK/UUQbcbWvdWYnz6O6u+CfVfBnnXWm+Qmvtjl/fGrr6R4aPC8AeB629x8bQc02zd5rNc\nqtcp67ytPl3MhyfVXa/zJV/eNN9n3Q9k4y/9fWUjuz0MgxSZtFt091FVK9q+jdp2OLTbdhqI\nPpDdVR/IRm+wbuXQzrU13dB1jyS6Pdi17fy9ines9QbpodKZo53ZxL3qGznufXrvX2vI3ihI\nxTXUXmGO9ikmLwjSLe/tm8/ZvVGQqqG/wADkKSYvCNJ1b/f2Uw1vFKTwx36cxl/reYbJK4Z2\nV739u/xZvhv1PkGiqCcWQaKoGYogUdQMRZAoaoYiSBQ1QxEkipqhCBJFzVDrDdL3g0wOqvkg\n+wgkSItDNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclB\nNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKF\nyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJ\nkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUf\nZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclB\nNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKF\nyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJ\nkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1H2QJkoXJQTUf\nZAmShclBNR9kCZKFyUE1H2QJkoXJQTUfZAmShclBNR9kCZKFyUE1n2myX2W9ykemZwnS4lDN\nZ4rsV1uv8ZHpWYK0OFTzmSD79XU9SXKy80KCtDhU83lY9qtfL/CR6VmCtDhU8yFIBMnC5KCa\nz6OygxyFJLm6oi0/3GBx/T1LkBaHaj4Pyo7kKE9SnSPfbnl0brC4/p69K0i+rGv01pY/r3Jv\nqfTgZKjmM2uQyjq6U7Plp2uC1C6uv2fvC9LDlCBJ7fIJsqM5qpJ0cUmz5c7t6/REi+vv2fUG\n6S9KqW4FaRu+79Xh5z6yOj3R4tsGqR7hRY8NrV7z2ZDFr/m6Pd/ZZNhmf19VLX3kUJ26EaSD\nO3QOv/Ya6e2D5Ksv8aP3PeZHmO9sVwepv0lnu/6+6lr6yKE6dSVI33n98cd3p5wbW1xlPRok\n35w6hkHqjNuusNEA9l6+tn1/WLj0kUN16voZ6TMfwmWckeK6eUaKqL92JmlPPe06vafD7Zv0\ndqOk0oOToZrP3JMNG5d2tyRItiCNnWbGzkjlsu9teeM01Y2SSg9Ohmo+Mwfp4ra9LQmSKUhm\nVi4PgnRzSBc9UenByVDNZ+bPkaqRHUGK6maQ4smG/tDuymRD/4vvb39rskGlBydDNZ+Zg5S4\nU29LghRNBtye/u6l4tr0d9NkPIcRT3vXj91tbrwdA5ODaj6Pyo7nKL9EulRbNp8fvX2QXl/9\nqbqoVHpwMlTzeVh2NEdRVgjSItUfyvVLpQcnQzWfmYP0XB+ZntUNUn8o1y+VHpwM1XwmyF6P\nkaDsvFA4SD+USg9Ohmo+U2Sv50hQdlZIkBaHaj7TZK/ESFN2RkiQFodqPsgSJAuTg2o+yBIk\nC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7I\nEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4Nq\nPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuT\ng2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIk\nC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7I\nEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4Nq\nPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuT\ng2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIk\nC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7I\nEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4Nq\nPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuT\ng2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIk\nC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7I\nEiQLk4NqPsgSJAuTg2o+yBIkC5ODaj7IEiQLk4NqPg/LfpX1Uh+ZniVIi0M1nwdlv9p6oY9M\nzxKkxaGaz2OyX18/JElJ9gmQIC0O1Xwekf3q16t8ZHqWIC0O1XwIEkGyMDmo5vOA7CBHI0mS\nkX0OJEiLQzWf+2VHcpQnydVVb5km3vl9Gp6kiXPb0yKyT4L2IPmyRkDvcc660aZKD06Gaj5z\nB8nXW27ap75YPC4h+yR4R5DuBs8tlR6cDNV87pYdzVE9uDu66sTzfXTbc3behOd7l2TZwW0W\nkH0WXG+Q/qJE6laQLiEyRX0nRaSObh9OSGGA59qD7z2DVI/wqkef1Y+Dl8ZWtz6GNuI2s97A\ncunDh6rrVpC2zbfse1uk5+K21QsfIVK3js3JUDxIvvrSPPrmef+l0dWtj3789bqWPnyouq4E\n6Tuv/3L/9V2Xc/HDvzqXfK++HgpSZ67Btwd1dKRfO+gHq/cDdu31/mNUSx8+VF03zkjRGOK7\nGslVD4edf/czUjv48i24FaRy9UFgfLeZkeaqM1NvvVtvx8DkoJrPjJMNn+6j3bIbpLwSd3i9\n7LPgQ9dIzbN2CHcjSPEQLRs+Zr0o3TgTdaKk0oOToZrPjEHaFJdF1ZaDIKWu+X6uv2cnXCPV\nT34I0s0hXL/xn4Z00ROVHpwM1Xzm+hwpnljImsmGNHqtzdT6e/bBIPnxI/5akK6s/tDjzbdj\nYHJQzWe+IMUju+x7X01/J1k1/X1pP0haf88+OP1dxWMwFuu9NLa6ffo7y0a3u/V2DEwOqvk8\nIHtlqiFx8W8BlR/IbsPvMxQfyKa797xGUiuVHpwM1XwekR3NUX6JdKl4Poj7rn4vaBOel4vt\nIG/9PUuQFodqPvMFqb0GKoJ0Cb+0mpTTD3vvNod2+/X3LEFaHKr5PCY7jNFLfGR6liAtDtV8\nHpT9IUdasvNDgrQ4VPN5WPZWjORkCVJdKj04Gar5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\nIEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwO\nqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5As\nTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBL\nkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\nIEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwO\nqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5As\nTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBL\nkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\nIEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwO\nqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5As\nTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBL\nkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\nIEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwO\nqvkgS5AsTA6q+SBLkCxMDqr5PCj7VdaLfWR6liAtDtV8HpL9auulPjI9S5AWh2o+j8h+ff2Y\n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\nPvfIjuQoJOlY3tOtuRdVeZO3fb6U+tHbva2/Z28GyVeVL91arb/VHetOaEulBydDNZ/pQUqd\nP2fprkhOqL3bpdn3Pvw69N4laZYO/rTq+nv2dpBGlm699NJS6cHJUM3nDtnRHH19fZYnn+a3\nNr3Lz03fafh16PLuOjksKWAAABQpSURBVIM/9r3+nl1vkP6iFq8rQdr1/ilOEZvvzG26r0T1\nVkEqB3n1Y/E1/883IDzxvXWzwXbmx6Lt4X6bWvogoq4GKT/t7L3bNddB9RmpOdhOzajv1rE5\nGWoGyY88NsEpXvAN8NHWY9uZHv3463UtfRBRV4Pk3J9hRuGPf3yXlbjk+/sf+WvV8+8/G7Ty\nsgYpnmzoHNDVMd0e3N0VBsO+3naDza69PrJfgqRTV4MU/qbJvjntlFN12+aMtHXH3jfzrc5I\nvQk8e5CG29Wv+ua01j4Oz0y99W69HQOTg2o+0ycbXBjKxf9E9JI4nzQXRsMc/YKevXNolz0Q\nJH99+3oxjtKNM1EnSio9OBmq+UwP0rY8qrozCt/ncs77svWnRWSfC58fpJtDuP6efhrSRU9U\nenAyVPOZ/jlS8YlRfkbaVGuVkw2HYqh39GHYt4jsU+HEyYYsux4k3zbirwXkgUfLe1U7/H6t\n7HiQzm6bhmukj2qtffgE6e+bEK8cLSb7VHjHbzb0p6er2en2hSxrE9ad/h7b/ufp72x0v5b3\nqnb4/V7ZsRyF5ITahBXC+C5tf0UoGf9nOuvvWX7XbnGo5nOf7FiOsuxz43w5Z1dE5pLn589j\n+ZQgiZVKD06Gaj5zBOllPjI9S5AWh2o+98qaYqQi+zRIkBaHaj53y5pypCL7LEiQFodqPg/I\nVjFah+xzIEFaHKr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBL\nkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\nIEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwO\nqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5As\nTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBL\nkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\nIEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwO\nqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5As\nTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBL\nkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\nIEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwO\nqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5As\nTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBL\nkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5\n3C/7VdY6ZJ8ECdLiUM3nXtmvtl7vI9OzBGlxqOZzp+zXly1JErLPgwRpcajmc5fsV79e7CPT\nswRpcajmQ5AIkoXJQTWfe2QHOaqSdNo6l1za9fbe/fOxWErzRR+j18k+FRKkxaGazx2yIzkq\nknR0oXxar+eL5/t8KS0X/eVWs8+RfS6cJ0g+r4kt3L2aSg9Ohmo+04OUOn/O0l2RnFB7t0uz\n7707h8UkzdKt271e9rlwliD55stVamri53UJ0sKww0ZzlCfpszz5uPq75V1+bvpOXRIWswK5\nG80+R/bJcI4g/RCCJwXpL2rpuhakXTj3RFXE5jtzm+4rURGkUD5aqsZ41ViveF4sxoO/GFbP\nqzZ8udhu4OsdNNs0tfRRRF0NUn7a2Xu3a66D6jNSc7CdmlFfVQQpVBuS+mCvx3rNwR8P/vrQ\n1xtm0XK1Uh2kZpt2r0sfRdS1IH0792eYUfjjH99lJS75/v5H/lr1/PvPBq285g1SFaY4I73H\n4ZBtbKXBur55gSAp1rUzknPbS5hXqE875VTdtjkjbd2xdzhwRopqJBttRjqzetGw7XqQ2pWq\nkZ3vBkmlBydDNZ/pkw0uDOWiyYbskjifNBdGwxz9gp59VZDiKI2dZQZBageF8VmKIC0MTUHa\nlkdVd0bh+1zOeV+2/rSE7JPhvLN2t4I0vEYaWal7PUWQ5KDpc6TiE6P8jLSpVisnGw7FUO/o\nt5dsUOvv2XkmG4qv9dLVa6TehEK8kh8Lku9GqneNpNKDk6Gaz/Qgnd02DXH6qFbbh0+Q/r4J\n8crRUrLPhfP+ZsNw+jur5iF609/dlDXT392Z8Dh+w+lvlR6cDNV87pEdzVFITqhNWAzju7T9\nFaHEVbWA7FPhvL9rN5ice2Kp9OBkqOZzl+xojrLsc+N8OWdXROaS5+fPY/mUIBmKID0A1Xzm\nCNLLfGR6liAtDtV87pS1xUhE9nmQf0axOFTzuVfWliMR2adBgrQ4VPO5X7aO0SpknwQJ0uJQ\nzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRh\nclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mC\nZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0H\nWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQ\nzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRh\nclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mC\nZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0H\nWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQ\nzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRh\nclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mC\nZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0H\nWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQ\nzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRh\nclDNB1mCZGFyUM0HWYJkYXJQzQdZgmRhclDNB1mCZGFyUM0HWYJkYXJQzec+2a+ylvKR6VmC\ntDhU87lH9qutZXxkepYgLQ7VfO6Q/frqJElb9rmQIC0O1XzMsl/9UpZ9NiRIi0M1H4JEkCxM\nDqr5WGUHOaqmHF7qI9OzBGlxqOZjlB3JUZGk09a55NKslu698/u03vI4fsCtv2cnBMl3HqZs\nH5b8zXZGoEoPToZqPtOCdHShfFqtdfHl80u55cURpEHNF6QrrfjRxbpUenAyVPOxyY7m6Osr\ndf6cpTu3r1ZLiqW9S8otNwRpWAsH6S9qyboSpM8iOHmcqu9SFZz8IRx+O0+QhhUFwftiZOaz\n4rF8Ur+YZYMVylXioZ2vN4y29E0DPt5JXUsfSW9eV4K0c+fuQVIFyYfD7+COBGlY3Wuc4rG5\n2IlebB58l/nO9j5eq/tyFaS4vVBLH0lvXleC9If7Tv5w//q/31X9p0vyr4n7z/zr3/Nl575/\nU80TpKqGCRgEaZC4QRAHQcra1/xoe0sfSW9eV4Lk3LYz2ZAdwmyDP+Q/x1O/bYZ6/eKMdCUf\n9cisN7b7IUj1Fs2IrhMk3x3bqfTgZKjmM2myIQ/SJUwu1JMN2a6YtUvyLbfuQpDG6qcg9de1\nnZGqF6MzlB9pL9PpwclQzWdikMK5qJ1s2FezdvsscZ8ZQRqrO4I0cvVzO0jxWgRJCP70OdK2\nmaXL4oU8WK6pBWSfD58cpGiyoT+0M0029IPE0G5h+FOQ9sWsXeo21Vrt9DdBuladkMRjse6L\n5Uq+O/PWn/6uSHfivNdob/pbpQcnQzUfq+xYjrKz26ZhKPdRrbRzh+L5rtqSod1i1R/S1aXS\ng5Ohmo9ZdpCjAPfFSWcTeAhN71eECNJyRZCU4I9Byj43zpdzdkVoer+0SpAWquu/y6rSg5Oh\nms8dsr1xnbbsc6F6kK6XSg9Ohmo+98h2cqQu+1RIkBaHaj73ybYxWoHsEyFBWhyq+SBLkCxM\nDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQ\nLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkg\nS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q\n+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxM\nDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQ\nLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkg\nS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q\n+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxMDqr5IEuQLEwOqvkgS5AsTA6q+SBLkCxM\nDqr5IEuQLEwOqvkgS5AsTA6q+SD7XkGiKKEiSBQ1QxEkipqhCBJFzVAEiaJmKIJEUTMUQaKo\nGYogUdQMRZAoaoYiSBQ1Q601SD6vRzd9+S4nyD5q6x/e56Mb+tfv8uEt/cTdjtRKg+SbL/dv\n+uj37OFdTpCdZvvwhq+N/ct71rfbzZaktwuSf/iQnrDLR7ecaPvwhq892b+6Z31GkOqa9EN+\n6n5ft6WfdGy+eMuHN379jyiCVBdB+mHDx69XspdffRKk5WqhIE2Yp3h0dy//If/4Tl8/jVO4\nEqQJtbIgPbbp1O/062dGJmz28JmXM9KUWiZILx4U+gkzyg/ucuLMyGM18YgmSBNqkSAtcqCs\n5fr94a24RlqylgjS2maUXx1BgrTGev1vNizyyf0k25dv+dhmC8j6ibsdqbUGiaKkiiBR1AxF\nkChqhiJIFDVDESSKmqEIEkXNUASJomYogqRazs3yvTlsndt+XoN3f47iqtqdhg3NI7zSeuf3\nLl3H/Gg9Tm7l4svjfjuO7z/0XVOn7ssPtfaL6p3fu3QlbueSya14l1zyUHp3GMWPBKl4SPdu\nM62h31Zv3wGq5Vwajs60OmA37pyliXNJWrCzz88xp51zfh/oZes2x+JgbtYp6tPtisej8/XB\nXnz98G5zKE8vYeuwzaVku3yLy8bt0ritan/N5s1CbVA2VP5/2Q2k3qHe5X2urY756SgJY7ud\nC4f4JeSpGKblj/nRus3xsRxi5QdtWg3gsmidonb1AOycxUHaF2sfquO/3NqngeXBcJ+b/EuS\nDfaXZVnvjNQYxEHyQ6l3qHd5n2urEKIQpvxL+PG+z59+hKW9K84k4bWN+8wTEo7Uj/waKN2W\nS/U6RXUO4zZI+WkjOzUnqX24gtq64sSS5CexfOmz21a5v6qR6BqpNWiukfLMpdkhtN1KvUW9\ny/tcW7VX75v631NvyiDsyiCEuhw/iiN1E55fyqV6nbaVTpPF1/zK6di+VG29qdrNx5QlGO4v\na4OUnDsGUZCqMWIk9Rb1Lu9zZVUNmsLY7pD/7D+5j/YYbvKx7T4vlzrjqStBOuajrk19wHe2\nzjqZ6O2vaeRYzwJ2DfoqA4PfXO/yPldWSf2DP0w3JPkAKx0e2InbHI6Xm0FqrpGyU/fIPm+c\nPz0cpHI0ODAgSJRaeVdMm4VrjfxwvRRjtU3zvYqO0XRsaNdUPWt38km1fjPWOjQHezy0y6Iv\n/f3Fi5twiowMRoLE0I5avE7VJFkSziin6tPPfbjk/wzngvpoPVVX89V0gYvXKav5HOkclj+r\n9X2+5Xl0siGLvvT3l2VZs3h2ocXWYCRIrdRb1Lu8z3XVvhqSHavpuU14Us0nn9vxVT30amea\n23XKumyaOfJy/Y92+ru47PLd6e8s+tLfX1H14kdwag1cHcs2SEx/U4tXcy+BYuHgyt+VCx+c\nbkPCqqOzeFoO2LZu81ku1evUdUx8/bt2e5+HpzwJeec/ipZ91v1ANv7S318WLxaDu8bgMAxS\nJPUO9S7v8w3KzXcnj/lKUuoZRZB+QRXXUPsZfjVvzpKUel4RpF9Q1bXK5ec1X1iSUs8rgvQb\n6rCprnKUSlLqaUWQKGqGIkgUNUMRJIqaoQgSRc1QBImiZiiCRFEzFEGiqBmKIFHUDPX/AY03\nd8RR7abdAAAAAElFTkSuQmCC",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 6: CUSTOMER SATISFACTION BY PRODUCT LINE\n",
    "# =========================================================\n",
    "\n",
    "# Calculate average customer rating for each product line\n",
    "\n",
    "product_rating <- sales %>%\n",
    "  \n",
    "  group_by(product_line) %>%\n",
    "  \n",
    "  summarise(\n",
    "    average_rating = mean(rating, na.rm = TRUE),\n",
    "    .groups = \"drop\"\n",
    "  ) %>%\n",
    "  \n",
    "  arrange(average_rating)\n",
    "\n",
    "\n",
    "# Display the summary table\n",
    "\n",
    "product_rating\n",
    "\n",
    "\n",
    "# Create a lollipop chart\n",
    "\n",
    "plot6 <- ggplot(\n",
    "  product_rating,\n",
    "  aes(\n",
    "    x = reorder(product_line, average_rating),\n",
    "    y = average_rating\n",
    "  )\n",
    ") +\n",
    "  \n",
    "  geom_segment(\n",
    "    aes(\n",
    "      xend = product_line,\n",
    "      y = 0,\n",
    "      yend = average_rating\n",
    "    ),\n",
    "    linewidth = 1.2,\n",
    "    color = \"gray70\"\n",
    "  ) +\n",
    "  \n",
    "  geom_point(\n",
    "    size = 6,\n",
    "    color = \"goldenrod\"\n",
    "  ) +\n",
    "  \n",
    "  geom_text(\n",
    "    aes(\n",
    "      label = round(average_rating, 2)\n",
    "    ),\n",
    "    hjust = -0.3,\n",
    "    size = 4\n",
    "  ) +\n",
    "  \n",
    "  coord_flip() +\n",
    "  \n",
    "  scale_y_continuous(\n",
    "    limits = c(0, 10),\n",
    "    breaks = seq(0, 10, 1),\n",
    "    expand = expansion(mult = c(0, 0.12))\n",
    "  ) +\n",
    "  \n",
    "  labs(\n",
    "    title = \"Customer Satisfaction Across Product Lines\",\n",
    "    subtitle = \"Average customer rating for each product category\",\n",
    "    x = \"Product Line\",\n",
    "    y = \"Average Customer Rating\"\n",
    "  ) +\n",
    "  \n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot6\n",
    "\n",
    "\n",
    "# Save the graph in the graphs folder\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/06_customer_satisfaction_product_line.png\",\n",
    "  plot = plot6,\n",
    "  width = 11,\n",
    "  height = 7,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 39,
   "id": "16fd1c3f-0754-449f-90bc-e505b2b0b671",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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\nRK5CYII=",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 7: SALES DISTRIBUTION BY CUSTOMER TYPE\n",
    "# =========================================================\n",
    "\n",
    "# Create the violin plot\n",
    "\n",
    "plot7 <- ggplot(\n",
    "  sales,\n",
    "  aes(\n",
    "    x = customer_type,\n",
    "    y = sales,\n",
    "    fill = customer_type\n",
    "  )\n",
    ") +\n",
    "\n",
    "  geom_violin(\n",
    "    trim = FALSE,\n",
    "    alpha = 0.7\n",
    "  ) +\n",
    "\n",
    "  geom_boxplot(\n",
    "    width = 0.15,\n",
    "    fill = \"white\",\n",
    "    outlier.shape = NA\n",
    "  ) +\n",
    "\n",
    "  stat_summary(\n",
    "    fun = mean,\n",
    "    geom = \"point\",\n",
    "    shape = 23,\n",
    "    size = 3,\n",
    "    fill = \"red\"\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Sales Distribution by Customer Type\",\n",
    "    subtitle = \"The box shows the median and spread; the red point shows the mean\",\n",
    "    x = \"Customer Type\",\n",
    "    y = \"Sales Amount\",\n",
    "    fill = \"Customer Type\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal() +\n",
    "\n",
    "  theme(\n",
    "    legend.position = \"none\"\n",
    "  )\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot7\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/07_customer_type_violin.png\",\n",
    "  plot = plot7,\n",
    "  width = 9,\n",
    "  height = 6,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 40,
   "id": "f8307cc5-ec6f-42fa-a3a3-1f101668e01b",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 8: PAYMENT METHOD BY PRODUCT LINE\n",
    "# =========================================================\n",
    "\n",
    "# Calculate transaction count\n",
    "\n",
    "payment_product <- sales %>%\n",
    "\n",
    "  group_by(product_line, payment) %>%\n",
    "\n",
    "  summarise(\n",
    "    transaction_count = n(),\n",
    "    .groups = \"drop\"\n",
    "  )\n",
    "\n",
    "\n",
    "# Create the heatmap\n",
    "\n",
    "plot8 <- ggplot(\n",
    "  payment_product,\n",
    "  aes(\n",
    "    x = payment,\n",
    "    y = product_line,\n",
    "    fill = transaction_count\n",
    "  )\n",
    ") +\n",
    "\n",
    "  geom_tile(\n",
    "    color = \"white\",\n",
    "    linewidth = 0.5\n",
    "  ) +\n",
    "\n",
    "  geom_text(\n",
    "    aes(\n",
    "      label = transaction_count\n",
    "    ),\n",
    "    size = 4\n",
    "  ) +\n",
    "\n",
    "  scale_fill_gradient(\n",
    "    low = \"lightblue\",\n",
    "    high = \"navy\"\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Payment Preferences Across Product Lines\",\n",
    "    subtitle = \"Numbers show the number of transactions\",\n",
    "    x = \"Payment Method\",\n",
    "    y = \"Product Line\",\n",
    "    fill = \"Transactions\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot8\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/08_payment_product_heatmap.png\",\n",
    "  plot = plot8,\n",
    "  width = 11,\n",
    "  height = 7,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 41,
   "id": "371a83d6-7669-4e85-b4d8-ec9bf47da9d1",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`geom_smooth()` using formula = 'y ~ x'\n",
      "\u001b[1m\u001b[22m`geom_smooth()` using formula = 'y ~ x'\n"
     ]
    },
    {
     "data": {
      "image/png": "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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# =========================================================\n",
    "# VISUALIZATION 6: UNIT PRICE VS SALES\n",
    "# =========================================================\n",
    "\n",
    "plot6 <- ggplot(\n",
    "  sales,\n",
    "  aes(\n",
    "    x = unit_price,\n",
    "    y = sales\n",
    "  )\n",
    ") +\n",
    "\n",
    "  geom_point(\n",
    "    alpha = 0.5,\n",
    "    color = \"steelblue\",\n",
    "    size = 2\n",
    "  ) +\n",
    "\n",
    "  geom_smooth(\n",
    "    method = \"lm\",\n",
    "    se = TRUE,\n",
    "    color = \"red\",\n",
    "    linewidth = 1\n",
    "  ) +\n",
    "\n",
    "  labs(\n",
    "    title = \"Relationship Between Unit Price and Sales\",\n",
    "    subtitle = \"The trend line shows the overall relationship\",\n",
    "    x = \"Unit Price\",\n",
    "    y = \"Sales Amount\"\n",
    "  ) +\n",
    "\n",
    "  theme_minimal()\n",
    "\n",
    "\n",
    "# Display the graph\n",
    "\n",
    "plot6\n",
    "\n",
    "\n",
    "# Save the graph\n",
    "\n",
    "ggsave(\n",
    "  filename = \"graphs/06_unit_price_vs_sales_scatter.png\",\n",
    "  plot = plot6,\n",
    "  width = 10,\n",
    "  height = 6,\n",
    "  dpi = 300\n",
    ")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "015c03e9-9795-472e-a995-aa8d2ffad18d",
   "metadata": {},
   "source": [
    "# WEEK 3 — Statistical Analysis & Predictive Modeling in R"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 42,
   "id": "74a1715b-1edb-4c04-9405-d72462760d0e",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "\"packages 'tidyverse', 'corrplot' are in use and will not be installed\"\n",
      "also installing the dependencies 'colorspace', 'fracdiff', 'lmtest', 'urca', 'zoo', 'RcppArmadillo', 'cowplot', 'Deriv', 'forecast', 'Rcpp', 'clock', 'ipred', 'sparsevctrs', 'timeDate', 'doBy', 'SparseM', 'MatrixModels', 'nloptr', 'reformulas', 'RcppEigen', 'e1071', 'foreach', 'ModelMetrics', 'plyr', 'pROC', 'recipes', 'reshape2', 'carData', 'abind', 'Formula', 'pbkrtest', 'quantreg', 'lme4'\n",
      "\n",
      "\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/colorspace_2.1-3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/lmtest_0.9-40.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/urca_1.3-4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/zoo_1.9-0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/RcppArmadillo_15.4.2-1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/cowplot_1.2.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/Deriv_4.3.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/forecast_9.0.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/Rcpp_1.1.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/clock_0.7.4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/ipred_0.9-15.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/sparsevctrs_0.3.6.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/timeDate_4052.112.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/doBy_4.7.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/SparseM_1.84-2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/MatrixModels_0.5-4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/nloptr_2.2.1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/reformulas_0.4.4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/RcppEigen_0.3.4.0.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/e1071_1.7-17.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/foreach_1.5.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/ModelMetrics_1.2.2.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/plyr_1.8.9.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/pROC_1.19.0.1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/recipes_1.3.3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/reshape2_1.4.5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/carData_3.0-6.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/abind_1.4-8.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/Formula_1.2-6.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/pbkrtest_0.5.5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/quantreg_6.1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/lme4_2.0-6.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/caret_7.0-1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/car_3.1-5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"some files were not downloaded\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'colorspace' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'lmtest' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'urca' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'zoo' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'RcppArmadillo' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'cowplot' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'Deriv' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'forecast' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'Rcpp' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'clock' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'ipred' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'sparsevctrs' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'timeDate' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'doBy' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'SparseM' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'MatrixModels' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'nloptr' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'reformulas' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'RcppEigen' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'e1071' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'foreach' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'ModelMetrics' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'plyr' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'pROC' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'recipes' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'reshape2' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'carData' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'abind' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'Formula' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'pbkrtest' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'quantreg' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'lme4' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'caret' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'car' failed\"\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'fracdiff' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\Shreya Srinath\\AppData\\Local\\Temp\\RtmpaWFcAu\\downloaded_packages\n"
     ]
    },
    {
     "ename": "ERROR",
     "evalue": "Error in library(caret): there is no package called 'caret'\n",
     "output_type": "error",
     "traceback": [
      "Error in library(caret): there is no package called 'caret'\nTraceback:\n",
      "1. stop(packageNotFoundError(package, lib.loc, sys.call()))"
     ]
    }
   ],
   "source": [
    "# Install packages if required\n",
    "install.packages(c(\"tidyverse\", \"caret\", \"car\", \"corrplot\"))\n",
    "\n",
    "library(tidyverse)\n",
    "library(caret)\n",
    "library(car)\n",
    "library(corrplot)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 43,
   "id": "e274e942-ad8c-4d88-bf8d-dee7d71a54a3",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t1000 obs. of  25 variables:\n",
      " $ invoice_id             : chr  \"750-67-8428\" \"226-31-3081\" \"631-41-3108\" \"123-19-1176\" ...\n",
      " $ branch                 : chr  \"Alex\" \"Giza\" \"Alex\" \"Alex\" ...\n",
      " $ city                   : chr  \"Yangon\" \"Naypyitaw\" \"Yangon\" \"Yangon\" ...\n",
      " $ customer_type          : chr  \"Member\" \"Normal\" \"Normal\" \"Member\" ...\n",
      " $ gender                 : chr  \"Female\" \"Female\" \"Female\" \"Female\" ...\n",
      " $ product_line           : chr  \"Health and beauty\" \"Electronic accessories\" \"Home and lifestyle\" \"Health and beauty\" ...\n",
      " $ unit_price             : num  74.7 15.3 46.3 58.2 86.3 ...\n",
      " $ quantity               : int  7 5 7 8 7 7 6 10 2 3 ...\n",
      " $ tax_5                  : num  26.14 3.82 16.22 23.29 30.21 ...\n",
      " $ sales                  : num  549 80.2 340.5 489 634.4 ...\n",
      " $ date                   : Date, format: \"2019-01-05\" \"2019-03-08\" ...\n",
      " $ time                   : chr  \"1:08:00 PM\" \"10:29:00 AM\" \"1:23:00 PM\" \"8:33:00 PM\" ...\n",
      " $ payment                : chr  \"Ewallet\" \"Cash\" \"Credit card\" \"Ewallet\" ...\n",
      " $ cogs                   : num  522.8 76.4 324.3 465.8 604.2 ...\n",
      " $ gross_margin_percentage: num  4.76 4.76 4.76 4.76 4.76 ...\n",
      " $ gross_income           : num  26.14 3.82 16.22 23.29 30.21 ...\n",
      " $ rating                 : num  9.1 9.6 7.4 8.4 5.3 4.1 5.8 8 7.2 5.9 ...\n",
      " $ sales_normalized       : num [1:1000, 1] 0.9191 -0.9872 0.0714 0.6754 1.2665 ...\n",
      "  ..- attr(*, \"scaled:center\")= num 323\n",
      "  ..- attr(*, \"scaled:scale\")= num 246\n",
      " $ gender_encoded         : num  1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ payment_encoded        : num  3 1 2 3 3 3 3 3 2 2 ...\n",
      " $ customer_type_encoded  : num  1 2 2 1 1 1 1 1 1 1 ...\n",
      " $ month                  : Ord.factor w/ 12 levels \"Jan\"<\"Feb\"<\"Mar\"<..: 1 3 3 1 2 3 2 2 1 2 ...\n",
      " $ day                    : chr  \"Saturday\" \"Friday\" \"Sunday\" \"Sunday\" ...\n",
      " $ hour                   : int  13 10 13 20 10 18 14 11 17 13 ...\n",
      " $ time_period            : chr  \"Afternoon\" \"Morning\" \"Afternoon\" \"Evening\" ...\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'invoice_id'</li><li>'branch'</li><li>'city'</li><li>'customer_type'</li><li>'gender'</li><li>'product_line'</li><li>'unit_price'</li><li>'quantity'</li><li>'tax_5'</li><li>'sales'</li><li>'date'</li><li>'time'</li><li>'payment'</li><li>'cogs'</li><li>'gross_margin_percentage'</li><li>'gross_income'</li><li>'rating'</li><li>'sales_normalized'</li><li>'gender_encoded'</li><li>'payment_encoded'</li><li>'customer_type_encoded'</li><li>'month'</li><li>'day'</li><li>'hour'</li><li>'time_period'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'invoice\\_id'\n",
       "\\item 'branch'\n",
       "\\item 'city'\n",
       "\\item 'customer\\_type'\n",
       "\\item 'gender'\n",
       "\\item 'product\\_line'\n",
       "\\item 'unit\\_price'\n",
       "\\item 'quantity'\n",
       "\\item 'tax\\_5'\n",
       "\\item 'sales'\n",
       "\\item 'date'\n",
       "\\item 'time'\n",
       "\\item 'payment'\n",
       "\\item 'cogs'\n",
       "\\item 'gross\\_margin\\_percentage'\n",
       "\\item 'gross\\_income'\n",
       "\\item 'rating'\n",
       "\\item 'sales\\_normalized'\n",
       "\\item 'gender\\_encoded'\n",
       "\\item 'payment\\_encoded'\n",
       "\\item 'customer\\_type\\_encoded'\n",
       "\\item 'month'\n",
       "\\item 'day'\n",
       "\\item 'hour'\n",
       "\\item 'time\\_period'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'invoice_id'\n",
       "2. 'branch'\n",
       "3. 'city'\n",
       "4. 'customer_type'\n",
       "5. 'gender'\n",
       "6. 'product_line'\n",
       "7. 'unit_price'\n",
       "8. 'quantity'\n",
       "9. 'tax_5'\n",
       "10. 'sales'\n",
       "11. 'date'\n",
       "12. 'time'\n",
       "13. 'payment'\n",
       "14. 'cogs'\n",
       "15. 'gross_margin_percentage'\n",
       "16. 'gross_income'\n",
       "17. 'rating'\n",
       "18. 'sales_normalized'\n",
       "19. 'gender_encoded'\n",
       "20. 'payment_encoded'\n",
       "21. 'customer_type_encoded'\n",
       "22. 'month'\n",
       "23. 'day'\n",
       "24. 'hour'\n",
       "25. 'time_period'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"invoice_id\"              \"branch\"                 \n",
       " [3] \"city\"                    \"customer_type\"          \n",
       " [5] \"gender\"                  \"product_line\"           \n",
       " [7] \"unit_price\"              \"quantity\"               \n",
       " [9] \"tax_5\"                   \"sales\"                  \n",
       "[11] \"date\"                    \"time\"                   \n",
       "[13] \"payment\"                 \"cogs\"                   \n",
       "[15] \"gross_margin_percentage\" \"gross_income\"           \n",
       "[17] \"rating\"                  \"sales_normalized\"       \n",
       "[19] \"gender_encoded\"          \"payment_encoded\"        \n",
       "[21] \"customer_type_encoded\"   \"month\"                  \n",
       "[23] \"day\"                     \"hour\"                   \n",
       "[25] \"time_period\"            "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "Member Normal \n",
       "   565    435 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>invoice_id</dt><dd>0</dd><dt>branch</dt><dd>0</dd><dt>city</dt><dd>0</dd><dt>customer_type</dt><dd>0</dd><dt>gender</dt><dd>0</dd><dt>product_line</dt><dd>0</dd><dt>unit_price</dt><dd>0</dd><dt>quantity</dt><dd>0</dd><dt>tax_5</dt><dd>0</dd><dt>sales</dt><dd>0</dd><dt>date</dt><dd>0</dd><dt>time</dt><dd>0</dd><dt>payment</dt><dd>0</dd><dt>cogs</dt><dd>0</dd><dt>gross_margin_percentage</dt><dd>0</dd><dt>gross_income</dt><dd>0</dd><dt>rating</dt><dd>0</dd><dt>18</dt><dd>0</dd><dt>gender_encoded</dt><dd>0</dd><dt>payment_encoded</dt><dd>0</dd><dt>customer_type_encoded</dt><dd>0</dd><dt>month</dt><dd>0</dd><dt>day</dt><dd>0</dd><dt>hour</dt><dd>0</dd><dt>time_period</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[invoice\\textbackslash{}\\_id] 0\n",
       "\\item[branch] 0\n",
       "\\item[city] 0\n",
       "\\item[customer\\textbackslash{}\\_type] 0\n",
       "\\item[gender] 0\n",
       "\\item[product\\textbackslash{}\\_line] 0\n",
       "\\item[unit\\textbackslash{}\\_price] 0\n",
       "\\item[quantity] 0\n",
       "\\item[tax\\textbackslash{}\\_5] 0\n",
       "\\item[sales] 0\n",
       "\\item[date] 0\n",
       "\\item[time] 0\n",
       "\\item[payment] 0\n",
       "\\item[cogs] 0\n",
       "\\item[gross\\textbackslash{}\\_margin\\textbackslash{}\\_percentage] 0\n",
       "\\item[gross\\textbackslash{}\\_income] 0\n",
       "\\item[rating] 0\n",
       "\\item[18] 0\n",
       "\\item[gender\\textbackslash{}\\_encoded] 0\n",
       "\\item[payment\\textbackslash{}\\_encoded] 0\n",
       "\\item[customer\\textbackslash{}\\_type\\textbackslash{}\\_encoded] 0\n",
       "\\item[month] 0\n",
       "\\item[day] 0\n",
       "\\item[hour] 0\n",
       "\\item[time\\textbackslash{}\\_period] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "invoice_id\n",
       ":   0branch\n",
       ":   0city\n",
       ":   0customer_type\n",
       ":   0gender\n",
       ":   0product_line\n",
       ":   0unit_price\n",
       ":   0quantity\n",
       ":   0tax_5\n",
       ":   0sales\n",
       ":   0date\n",
       ":   0time\n",
       ":   0payment\n",
       ":   0cogs\n",
       ":   0gross_margin_percentage\n",
       ":   0gross_income\n",
       ":   0rating\n",
       ":   018\n",
       ":   0gender_encoded\n",
       ":   0payment_encoded\n",
       ":   0customer_type_encoded\n",
       ":   0month\n",
       ":   0day\n",
       ":   0hour\n",
       ":   0time_period\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "             invoice_id                  branch                    city \n",
       "                      0                       0                       0 \n",
       "          customer_type                  gender            product_line \n",
       "                      0                       0                       0 \n",
       "             unit_price                quantity                   tax_5 \n",
       "                      0                       0                       0 \n",
       "                  sales                    date                    time \n",
       "                      0                       0                       0 \n",
       "                payment                    cogs gross_margin_percentage \n",
       "                      0                       0                       0 \n",
       "           gross_income                  rating                         \n",
       "                      0                       0                       0 \n",
       "         gender_encoded         payment_encoded   customer_type_encoded \n",
       "                      0                       0                       0 \n",
       "                  month                     day                    hour \n",
       "                      0                       0                       0 \n",
       "            time_period \n",
       "                      0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# WEEK 3: Statistical Analysis and Predictive Modeling\n",
    "\n",
    "# Check the dataset\n",
    "str(sales)\n",
    "\n",
    "# Check column names\n",
    "names(sales)\n",
    "\n",
    "# Check customer type distribution\n",
    "table(sales$customer_type)\n",
    "\n",
    "# Check for missing values\n",
    "colSums(is.na(sales))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ba2107b1-8dec-4574-949b-ece9677842a9",
   "metadata": {},
   "source": [
    "# Predict Total Sales using Unit Price, Quantity, and Tax."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 44,
   "id": "1265caae-ca1b-4589-b1b9-4d4ae57354fa",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 10</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>customer_type</th><th scope=col>gender</th><th scope=col>product_line</th><th scope=col>unit_price</th><th scope=col>quantity</th><th scope=col>rating</th><th scope=col>payment</th><th scope=col>month</th><th scope=col>day</th><th scope=col>hour</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Member</td><td>Female</td><td>Health and beauty     </td><td>74.69</td><td>7</td><td>9.1</td><td>Ewallet    </td><td>Jan</td><td>Saturday</td><td>13</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>Normal</td><td>Female</td><td>Electronic accessories</td><td>15.28</td><td>5</td><td>9.6</td><td>Cash       </td><td>Mar</td><td>Friday  </td><td>10</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Normal</td><td>Female</td><td>Home and lifestyle    </td><td>46.33</td><td>7</td><td>7.4</td><td>Credit card</td><td>Mar</td><td>Sunday  </td><td>13</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>Member</td><td>Female</td><td>Health and beauty     </td><td>58.22</td><td>8</td><td>8.4</td><td>Ewallet    </td><td>Jan</td><td>Sunday  </td><td>20</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>Member</td><td>Female</td><td>Sports and travel     </td><td>86.31</td><td>7</td><td>5.3</td><td>Ewallet    </td><td>Feb</td><td>Friday  </td><td>10</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>Member</td><td>Female</td><td>Electronic accessories</td><td>85.39</td><td>7</td><td>4.1</td><td>Ewallet    </td><td>Mar</td><td>Monday  </td><td>18</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 10\n",
       "\\begin{tabular}{r|llllllllll}\n",
       "  & customer\\_type & gender & product\\_line & unit\\_price & quantity & rating & payment & month & day & hour\\\\\n",
       "  & <chr> & <chr> & <chr> & <dbl> & <int> & <dbl> & <chr> & <ord> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & Member & Female & Health and beauty      & 74.69 & 7 & 9.1 & Ewallet     & Jan & Saturday & 13\\\\\n",
       "\t2 & Normal & Female & Electronic accessories & 15.28 & 5 & 9.6 & Cash        & Mar & Friday   & 10\\\\\n",
       "\t3 & Normal & Female & Home and lifestyle     & 46.33 & 7 & 7.4 & Credit card & Mar & Sunday   & 13\\\\\n",
       "\t4 & Member & Female & Health and beauty      & 58.22 & 8 & 8.4 & Ewallet     & Jan & Sunday   & 20\\\\\n",
       "\t5 & Member & Female & Sports and travel      & 86.31 & 7 & 5.3 & Ewallet     & Feb & Friday   & 10\\\\\n",
       "\t6 & Member & Female & Electronic accessories & 85.39 & 7 & 4.1 & Ewallet     & Mar & Monday   & 18\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 10\n",
       "\n",
       "| <!--/--> | customer_type &lt;chr&gt; | gender &lt;chr&gt; | product_line &lt;chr&gt; | unit_price &lt;dbl&gt; | quantity &lt;int&gt; | rating &lt;dbl&gt; | payment &lt;chr&gt; | month &lt;ord&gt; | day &lt;chr&gt; | hour &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | Member | Female | Health and beauty      | 74.69 | 7 | 9.1 | Ewallet     | Jan | Saturday | 13 |\n",
       "| 2 | Normal | Female | Electronic accessories | 15.28 | 5 | 9.6 | Cash        | Mar | Friday   | 10 |\n",
       "| 3 | Normal | Female | Home and lifestyle     | 46.33 | 7 | 7.4 | Credit card | Mar | Sunday   | 13 |\n",
       "| 4 | Member | Female | Health and beauty      | 58.22 | 8 | 8.4 | Ewallet     | Jan | Sunday   | 20 |\n",
       "| 5 | Member | Female | Sports and travel      | 86.31 | 7 | 5.3 | Ewallet     | Feb | Friday   | 10 |\n",
       "| 6 | Member | Female | Electronic accessories | 85.39 | 7 | 4.1 | Ewallet     | Mar | Monday   | 18 |\n",
       "\n"
      ],
      "text/plain": [
       "  customer_type gender product_line           unit_price quantity rating\n",
       "1 Member        Female Health and beauty      74.69      7        9.1   \n",
       "2 Normal        Female Electronic accessories 15.28      5        9.6   \n",
       "3 Normal        Female Home and lifestyle     46.33      7        7.4   \n",
       "4 Member        Female Health and beauty      58.22      8        8.4   \n",
       "5 Member        Female Sports and travel      86.31      7        5.3   \n",
       "6 Member        Female Electronic accessories 85.39      7        4.1   \n",
       "  payment     month day      hour\n",
       "1 Ewallet     Jan   Saturday 13  \n",
       "2 Cash        Mar   Friday   10  \n",
       "3 Credit card Mar   Sunday   13  \n",
       "4 Ewallet     Jan   Sunday   20  \n",
       "5 Ewallet     Feb   Friday   10  \n",
       "6 Ewallet     Mar   Monday   18  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t1000 obs. of  10 variables:\n",
      " $ customer_type: chr  \"Member\" \"Normal\" \"Normal\" \"Member\" ...\n",
      " $ gender       : chr  \"Female\" \"Female\" \"Female\" \"Female\" ...\n",
      " $ product_line : chr  \"Health and beauty\" \"Electronic accessories\" \"Home and lifestyle\" \"Health and beauty\" ...\n",
      " $ unit_price   : num  74.7 15.3 46.3 58.2 86.3 ...\n",
      " $ quantity     : int  7 5 7 8 7 7 6 10 2 3 ...\n",
      " $ rating       : num  9.1 9.6 7.4 8.4 5.3 4.1 5.8 8 7.2 5.9 ...\n",
      " $ payment      : chr  \"Ewallet\" \"Cash\" \"Credit card\" \"Ewallet\" ...\n",
      " $ month        : Ord.factor w/ 12 levels \"Jan\"<\"Feb\"<\"Mar\"<..: 1 3 3 1 2 3 2 2 1 2 ...\n",
      " $ day          : chr  \"Saturday\" \"Friday\" \"Sunday\" \"Sunday\" ...\n",
      " $ hour         : int  13 10 13 20 10 18 14 11 17 13 ...\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "Member Normal \n",
       "   565    435 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Select variables for Week 3 analysis\n",
    "\n",
    "model_data <- sales %>%\n",
    "  select(\n",
    "    customer_type,\n",
    "    gender,\n",
    "    product_line,\n",
    "    unit_price,\n",
    "    quantity,\n",
    "    rating,\n",
    "    payment,\n",
    "    month,\n",
    "    day,\n",
    "    hour\n",
    "  )\n",
    "\n",
    "# View data\n",
    "head(model_data)\n",
    "\n",
    "# Check structure\n",
    "str(model_data)\n",
    "\n",
    "# Check customer type distribution\n",
    "table(model_data$customer_type)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 45,
   "id": "5c35556e-05e2-43a6-a744-e59f6bbc3a3e",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAANlBMVEUAAABNTU1ZWVloaGh8\nfHyMjIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD///8jvLTkAAAACXBIWXMA\nABJ0AAASdAHeZh94AAAgAElEQVR4nO3diXYayRKE4e4LEloxvP/LXnaaAiGNItNJlP/vnLHG\nWpAmKmJYhOVhDUA2VH8BQA8YEhCAIQEBGBIQgCEBARgSEIAhAQEYEhCAIQEBGBIQQB/SsDc+\nfx5+e/nm1fPF+954j4t3/OKNX1s9D8Ns8vu3p80X8/R+9yP+46e4MEwol4O+hA1pY7H/bfvm\n9jdfFHD/6v/czu1u5qfffY6Hr2X+9UdoA2BIuCViSLsXy9dhePn6zXdfc+/V33/6z/NvPjdX\nRh+blx/z4enOR/zqEwVfBPoSWKpNi1d33nznNfde/eNPvzUbXg//Nh++vHXHkBAvslSL7VXS\n/refz9t7TR+HW0LbF6vZ5krieNPuZRzm75MP3rw4veN6//Hj8V7X5jWLcZhNd3F+6+VNrPfz\n9dDn9obm+dKvv6L2c7zsP8fr5sV+jJtrtdMXufvir/+bV8d7Z9t/2bzu9fifNf3o82dGxyKH\n9Llt2+63H4c7Ee/nfTxt70MdhrQ43aX6Ykjvp4/fvmZ++ve9yVsvh/TUXA1NhnT1FTWf42X3\n7x/PuxfbJb2d7/cdvvgb/82Lwyd82/wv5HgZi/XlR39MPg+6FXoz57SE2fC23rZpdn4MYb46\nvu/m/8+bt76P2zs3k6pPHmzY3Eh8Wa1Xm70td+/+sV49nR8+uHjrxa2ssbltObn0q6+o/Rzv\n21mM+xez7Zvnm+uQz/l+rfPmNuvxky4PV0nzzYVM/7OmHz35zOhXzpCa121//Tj9Ztg16+rG\n12RIi8P//5/377L9f/lqegty8taLIX3xiOHkJuP5tbc/x+n25mK/ydX+Sra9XXa6tKfDB+72\nudy9aly0H/1VcuhIzpCeNncK3paTN0/vrRwfkzhfO7RDmh06uWzeZe/irT8d0tVX1HyOVfP+\ns8lj3HceL9ndmt3dslsfrzKfZpcfPfnM6FfskMbDb5e7b+fs7rXfGtL5A28P6XSRzbs0n/Dq\nu1Kzr2/affUV3foc+9f8aEibmXzub9mtj7fdZs1HTz4z+hU5pI/JLZn33d32l787pOfpPfpl\n86G3v6Kvh3Trv/D6NdurpP2Dd8chza+md/rM6FfkkBbbOz+Tjj2frqFu37T7cki/vWk3efh7\nOc6vP3T6Fd35HNsX4+T7vPeGtL022t2yWx8/9/am3fSjJ58Z/Qoc0ueuK+3/ym8NaXcz52OY\nH0f1fvVgw/7pcM/tN4N2Lt562fJx/zjG7vbU+8WlX31Fdz7H9sXz/s2fw/ybIb0Pi/nh4cP9\nAwzbBxumH339IehQ2JC2TxE63QPZP+S72N/UmzxIfRjS9q1v4/axsPnwtNo+ZDxcvONyGBb7\nh6Y/bwzp4q2XBf3YP0Vo9Trurh8ml371Fd35HNsXn7tvAn0e9vjFf/PObNzfqNs/hP6+ewh+\n+tGTz4x+RQzp6Pyk1cM3Icfl/gGsdkjn71zu33FxfJzsdH/m4pul5w/dm761vTty/Fp2tZ1c\n+tVXdOdzTN98daXXfjHbd3zZv+7p/FVNPnrymdGvsCHNFtM/RvGxe1rMtjufs/P9ktPDA9un\nCO2/N/OxefPL/jpg+o6XT9+ZvGjf2rZ89bJ9HsTz8Yk6p0u/+orufI79i+Xi+Gyh+0NaHb6B\ntHndZrKHr2ry0ZPPjH5xy131eni4jjtB/zROX/Q5Hp73wJD+aZy+5HTXkCH94zh9yez8lAWG\n9E/j9IEADAkIwJCAAAwJCMCQgAAMCQjAkIAADAkIwJCAAAyp8af6C+hZx+EypEbHZ12v43AZ\nUqPjs67XcbgMqdHxWdfrOFyG1Oj4rOt1HC5DanR81vU6DpchNTo+63odh8uQGh2fdb2Ow2VI\njY7Pul7H4TKkRsdnXa/jcBlSo+OzrtdxuAyp0fFZ1+s4XIbU6Pis63UcLkNqdHzW9ToOlyE1\nOj7reh2Hy5AaHZ91vY7DZUiNjs+6XsfhMqRGx2ddr+NwGVKj47Ou13G4DKnR8VnX6zhchtTo\n+KzrdRwuQ2p0fNb1Og6XITU6Put6HYfLkBodn3W9jsNlSI2Oz7pex+EypEbHZ12v43AZUqPj\ns67XcbgMqdHxWdfrOFyG1Oj4rOt1HC5DanR81vU6DpchNTo+63odh8uQGh2fdb2Ow2VIjY7P\nul7H4TKkRsdnXa/jcEuG9D/8TsVhRWJIsar7aKvisCIxpFjVfbRVcViRGFKs6j7aqjisSAwp\nVnUfbVUcViSGFKu6j7YqDisSQ4pV3UdbFYcViSHFqu6jrYrDisSQYlX30VbFYUViSLGq+2ir\n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\nE2md/nZIewzpIZBtIq3TP/4+EkN6AGSbSOs0Q3JCtom0TvPMBidkm0jrNM+1c0K2ibROMyQn\nZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2\nibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI\n6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibRO\nMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRD\nckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQn\nZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2ibROMyQnZJtI6zRDckK2\nibROMyQnZJtI6zRDckK2ibROt0N6Hdfrj2F80S71G9WR2SLbRFqnmyG9DsN6OQ7DkLqk6shs\nkW0irdPNkGbDx+af189h1C72vurIbJFtIq3TzZA2V0jvw2z3MlF1ZLbINpHW6WYw47B8Hj63\n95K0i72vOjJbZJtI63QzpJfN3aNxe4W00C72vurIbJFtIq3T7U24xTC+b66YUnfEYf8W2SbS\nOs33kZyQbSKt082Q5s/axf1MdWS2yDaR1umrBxu0i/uZ6shskW0irdPNcD7ni6V2gT9RHZkt\nsk2kdfrq+0hH2sXeVx2ZLbJNpHWaITkh20Rap3nUzgnZJtI6zZCckG0irdNXQ3p92tysm39q\nl/qN6shskW0irdPNkFaz3f2jYfjQLva+6shskW0irdPNkJ6HxfaZ32/DXLvY+6ojs0W2ibRO\nX/8xitM/eaojs0W2ibROMyQnZJtI6/Ttm3aLIfU5d9WR2SLbRFqn2wcbxv23Y8fUJwpVR2aL\nbBNpnb66CfcyG4bZYqVd6jeqI7NFtom0TvMNWSdkm0jrNENyQraJtE4zJCdkm0jrdPtgwzPP\n/n5gZJtI63QzmCf+GMUjI9tEWqevviH7pl3ej1RHZotsE2mdvvqRxdrF/Ux1ZLbINpHW6WY4\ny+xvIe1UR2aLbBNpnW6vgd64j/TAyDaR1mkebHBCtom0TvNggxOyTaR1+uoaSbu4n6mOzBbZ\n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\naYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1m\nSE7INpHWaXVIf36jOjJbZJvoN02OG9KvVEdmi2wTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHW\naYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1m\nSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbk\nhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7I\nNpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwT\naZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHW\naYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1m\nSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbk\nhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7I\nNpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwT\naZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHW\naYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1m\nSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbk\nhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7I\nNpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwT\naZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ1mSE7INpHW\naYbkhGwTaZ1mSE7INpHWaYbkhGwTaZ3+70MaN7TPyWH/Ftkm0jr9n4c0nn75verIbJFtIq3T\nDMkJ2f6Z7j8AAATZSURBVCbSOs2QnJBtIq3T6pD+AP+uuCF158/374Lf6jhchtTo+KzrdRwu\nQ2p0fNb1Og6XITU6Put6HYfLkBodn3W9jsMteWbDI+v4rOt1HG7Jc+0eWcdnXa/jcBlSo+Oz\nrtdxuAyp0fFZ1+s4XIbU6Pis63UcLkNqdHzW9ToOlyE1Oj7reh2Hy5AaHZ91vY7DZUiNjs+6\nXsfhMqRGx2ddr+NwGVKj47Ou13G4DKnR8VnX6zhchtTo+KzrdRwuQ2p0fNb1Og6XITU6Put6\nHYfLkBodn3W9jsNlSI2Oz7pex+EypEbHZ12v43AZUqPjs67XcbgMqdHxWdfrOFyG1Oj4rOt1\nHC5DanR81vU6DpchNTo+63odh8uQGh2fdb2Ow2VIjY7Pul7H4TKkRsdnXa/jcBlSo+Ozrtdx\nuAyp0fFZ1+s4XIYEBGBIQACGBARgSEAAhgQEYEhAAIYEBGBIQACGBARgSECAf3RIY/Pyq7fj\nd8aLFz96X3P/6pDG6Ysbb/97X0qXjvn+6H1Tv5K/hSHdfvvf+1K6NO4TZEi92x/04ddxPPxm\n+/LiNxdvLPxy7UyGNE3wIuPzW3rAkI4nvj/Ucfqb5o34sUN0t+Nt31L3ZQZiSBfn2f6mr8P+\ne24M6fBy+su6o2z/2SGdVjSO+5sYt4c0fSN+7Lyie0PqKVuGdPFI+FfXRH0c9t9zyO/+kKbX\nWfYYEkNK8JMh9XWz+d8d0t0b8X3eIf579nmN3w6Jm3bmxuk/k0dhz4fc40O0f894fnEr3tNb\n+vmf1D86JCAWQwICMCQgAEMCAjAkIABDAgIwJCAAQ3oEr/NhmL999cb//I2W4UT8uvBjRF1v\nOe5bP7/95v8+B4b09xF1vXF4Xq7X7+PwevPNv5sDI/q7iLvc2/C0e/k+jMf+7359GYfZ6/7q\nZfO75fOw29v2bU+bj1jOhqfV5rer7etXu9d/jpPrtP0FrYbZ8cXu4+bL9fRjEIYhlXsaPvb/\n8rmeDmmxu232ehjSanfzb1xt3/a0+be32eaX5/X26mxjtvuY+e4VB4drpMXwvt5u9WXziufD\nJZw/BmEYUrmLG2HnIQ3Dcv1xupJabO9BzYfF9rfPm2Fs/u1t+4aX7asWw+6aa3HjUj9397y2\nW90MbbW/hPPHIAxDKvfFkDb3nN7Pr5ptZrVebq9GtgPb/LLav2G2f/+nw+uvL/Vp2FzR7ff4\nebiE88cgDEMq98WQ3jc3wGbL46um11TT150fnmseXTj+9nMzmPftbb7pJfCQXjjSLHe6j7T+\nuHiwYf05G8YPdUjb67LdHSWGlIo0yx0ftfsYj9cby2PJX08Lmd60W09+mZ0O8KshvQ+Lcf/e\nu0uYTz8GYci03un7SJ/bf39br+b7+0gfm9tltx5sWE9+WWxf9bZ941dD2uxm94DD9tfNJb9M\nPwZhGFK95Wx/U2v7qNvuQe+X88PfL9sFjJcPf68nv+xfv3tA4ashvQ/D23r/8PjuoiYfgzAM\n6RG8P4/H59ptboe9HK6ExmHc7Ghz+27b/uk3ZKe/bF8//1jfGdLh8bzNr/P9JZw/BmEYUvc+\n9t975cGFVKTbvfnuyQ0MKRfpdu70rHKGlIp0Ozcen8HAkFKRLhCAIQEBGBIQgCEBARgSEIAh\nAQEYEhCAIQEB/g9sVOxY26y2WQAAAABJRU5ErkJggg==",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(model_data, aes(x = customer_type)) +\n",
    "  geom_bar() +\n",
    "  labs(\n",
    "    title = \"Distribution of Customer Types\",\n",
    "    x = \"Customer Type\",\n",
    "    y = \"Number of Customers\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 46,
   "id": "b7c1c936-1b75-44b9-9bcb-64f6e810a056",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   unit_price       quantity         rating           month    \n",
       " Min.   :10.08   Min.   : 1.00   Min.   : 4.000   Jan    :352  \n",
       " 1st Qu.:32.88   1st Qu.: 3.00   1st Qu.: 5.500   Mar    :345  \n",
       " Median :55.23   Median : 5.00   Median : 7.000   Feb    :303  \n",
       " Mean   :55.67   Mean   : 5.51   Mean   : 6.973   Apr    :  0  \n",
       " 3rd Qu.:77.94   3rd Qu.: 8.00   3rd Qu.: 8.500   May    :  0  \n",
       " Max.   :99.96   Max.   :10.00   Max.   :10.000   Jun    :  0  \n",
       "                                                  (Other):  0  \n",
       "        day            hour      \n",
       " Length   :1000   Min.   :10.00  \n",
       " N.unique :   7   1st Qu.:12.00  \n",
       " N.blank  :   0   Median :15.00  \n",
       " Min.nchar:   6   Mean   :14.91  \n",
       " Max.nchar:   9   3rd Qu.:18.00  \n",
       "                  Max.   :20.00  \n",
       "                                 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(\n",
    "  model_data %>%\n",
    "    select(unit_price, quantity, rating, month, day, hour)\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 47,
   "id": "7935a101-3e54-4bcc-8916-917465e7f3d4",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 1 × 9</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Mean_Unit_Price</th><th scope=col>Median_Unit_Price</th><th scope=col>SD_Unit_Price</th><th scope=col>Mean_Quantity</th><th scope=col>Median_Quantity</th><th scope=col>SD_Quantity</th><th scope=col>Mean_Rating</th><th scope=col>Median_Rating</th><th scope=col>SD_Rating</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>55.67213</td><td>55.23</td><td>26.49463</td><td>5.51</td><td>5</td><td>2.923431</td><td>6.9727</td><td>7</td><td>1.71858</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 1 × 9\n",
       "\\begin{tabular}{lllllllll}\n",
       " Mean\\_Unit\\_Price & Median\\_Unit\\_Price & SD\\_Unit\\_Price & Mean\\_Quantity & Median\\_Quantity & SD\\_Quantity & Mean\\_Rating & Median\\_Rating & SD\\_Rating\\\\\n",
       " <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 55.67213 & 55.23 & 26.49463 & 5.51 & 5 & 2.923431 & 6.9727 & 7 & 1.71858\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 1 × 9\n",
       "\n",
       "| Mean_Unit_Price &lt;dbl&gt; | Median_Unit_Price &lt;dbl&gt; | SD_Unit_Price &lt;dbl&gt; | Mean_Quantity &lt;dbl&gt; | Median_Quantity &lt;dbl&gt; | SD_Quantity &lt;dbl&gt; | Mean_Rating &lt;dbl&gt; | Median_Rating &lt;dbl&gt; | SD_Rating &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| 55.67213 | 55.23 | 26.49463 | 5.51 | 5 | 2.923431 | 6.9727 | 7 | 1.71858 |\n",
       "\n"
      ],
      "text/plain": [
       "  Mean_Unit_Price Median_Unit_Price SD_Unit_Price Mean_Quantity Median_Quantity\n",
       "1 55.67213        55.23             26.49463      5.51          5              \n",
       "  SD_Quantity Mean_Rating Median_Rating SD_Rating\n",
       "1 2.923431    6.9727      7             1.71858  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "stat_summary <- model_data %>%\n",
    "  summarise(\n",
    "    Mean_Unit_Price = mean(unit_price),\n",
    "    Median_Unit_Price = median(unit_price),\n",
    "    SD_Unit_Price = sd(unit_price),\n",
    "    \n",
    "    Mean_Quantity = mean(quantity),\n",
    "    Median_Quantity = median(quantity),\n",
    "    SD_Quantity = sd(quantity),\n",
    "    \n",
    "    Mean_Rating = mean(rating),\n",
    "    Median_Rating = median(rating),\n",
    "    SD_Rating = sd(rating)\n",
    "  )\n",
    "\n",
    "stat_summary"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 48,
   "id": "b7945678-7b45-461c-852f-d8c6688729cf",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(model_data, aes(x = quantity)) +\n",
    "  geom_histogram(bins = 10) +\n",
    "  labs(\n",
    "    title = \"Distribution of Quantity Purchased\",\n",
    "    x = \"Quantity\",\n",
    "    y = \"Frequency\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 49,
   "id": "a44f7759-39e7-4bc7-bef7-2dfe2c7e69f3",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAANlBMVEUAAABNTU1ZWVloaGh8\nfHyMjIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD///8jvLTkAAAACXBIWXMA\nABJ0AAASdAHeZh94AAAflklEQVR4nO3djVYayxKAUYhGT35M5P1f9ogoMlgDU0O3053Ze62b\nmEjKZqzviOhNNjvgZpulDwD/AiFBAUKCAoQEBQgJChASFCAkKEBIUICQoAAhQQHzQ9ocbB+e\n3n45fPXzw+C2wS0GNxx55bjnh83mbjA/PMbrr8/OcnD/4/xmMNvNIb14PPzy/NXnvxhZ1sNv\npzf5+76Fz28sPMbZWY4pjZwW0m4J6fWnPz82m//GX33xdy799vU3/xTNCKd9jvrF7+3mR3Bb\nmOPmkHa7p83m+cKrL/zOpd+e/OaHv5ge0u736YckuEmBkHaP+w9Jh18+Pew/a/r99gBq/9Pz\n3eb78QHWf9vN/a+TP/zy0/GGu8Of375/1vXyO4/bzd2vkzf58drN2x/7dJb3t/T+Rw+zx297\nesDd7tf9ZvNw+K/C75cX70/fOFxQIqSnl008/PL322cfvz76+L7/HOptvR+Pn1KNhPTr+Of3\nv3N/fPng5LXXQrr/uOG1kD4OuDucb7t/8efJp39wVYmQdscS7jY/d/slvPt4DuH+eXdc7+3L\na39t95/cfIR0+mTDy4PE/553zy/7/Of15r93z98/Hn8NXnvxod3JH42ebHh74dfh9R8HfNps\nf+2e7/f1PG3uXz6sPt1vfExikrIhffoP/2bz+/iLzWtlLzv6OBbS49tHgIfDTfZL/Hz6CPLk\ntVdCOv7R8ZBeiv41PODD67MPz/v/DDwePu173n+shevKhvT95VOYn39OXn0SzO79OYmPj1fn\nId1tDn/2z9lNDgavvRLScPrI09/Dx5j7N3B80uTueKPsZWGdyoS0ffvln+1+9+5+7OKQPv5g\nHNJx5NlNzt7ghYdr00Pafj971uPsPw1CIqNESL+PTza8PGB62G/ff02HFNyL+IEpTFUipMf9\nJz8fv3x6OH6Eih/ajYY0+6Hd/ftXZ59en5uYGdL246Hd9vTLvXBVgZCeXp8wPt3Psz6O6/z6\nnQS/D0+W7Xf216cnGw7fFPdw9nzEweC1wx7eX/X2hMTMkB7enqPY7l98ONw1X7NlkptD2n+L\n0PFzosPT34+Hh3onT1K/rfP+tT+3++fJ7jffn/fPm20GN/yz2TwenuB+CkIavHbYw/Nm8/Ay\n5c/jIdDPIf35dO7hr15/+rXZPh2f/n79cevpb6a5JaTP37T69gXZ7Z/D817nIf13vPnhho/7\n3z+94fALsh9/9OD0tWc9vL9qc/4Mwlvfo5/+DN7K4Quy9ycDfUGWaW4O6e7x9P9G8fv1W4T2\n//1/uvv4TOn4AGv/LUKvX7fZ/X559X+vvz+44fBbhE5+On/t+dMBT493+7OcPvX+EdLhTRzP\nPbwXpz/9eLnhWzt/9t9k5LtamcizU1CAkKAAIUEBQoIChAQFCAkKEBIUICQoQEhQgJCgACFB\nAUKCAoQEBSwW0l/jlxrf9eFbHS+k9Y3v+vCtjhfS+sZ3ffhWxwtpfeO7Pnyr44W0vvFdH77V\n8UJa3/iuD9/qeCGtb3zXh291vJDWN77rw7c6XkjrG9/14VsdL6T1je/68K2OF9L6xnd9+FbH\nC2l947s+fKvjhbS+8V0fvtXxQlrf+K4P3+p4Ia1vfNeHb3W8kNY3vuvDtzpeSOsb3/XhWx0v\npPWN7/rwrY4X0vrGd334VscLaX3juz58q+OFtL7xXR++1fFCWt/4rg/f6nghrW9814dvdbyQ\n1je+68O3Ol5I6xvf9eFbHS+k9Y3v+vCtjhfS+sZ3ffhWxwtpfeO7Pnyr44W0vvFdH77V8UJa\n3/iuD9/qeCGtb3zXh291vJDWN77rw7c6XkjrG9/14VsdL6T1je/68K2OnxvS36V9G7H0uViT\n20O62a3/YRkLqdD4K7oe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6\nHt/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/Xh\nWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+k\nWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f\n9eFbHS+kWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6Ht/14Vsd\nL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6\nHt/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/Xh\nWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+kWboe3/XhWx0vpFm6Ht/14VsdL6RZuh7f9eFbHS+k\nWboe3/XhWx0vpFm6Ht/14VsdL6RZuh5/0/Qr1/3W8dc1Ol5Is3Q9XkgVxgtplq7HC6nCeCHN\n0vV4IVUYL6RZuh4vpArjhTRL1+OFVGG8kGbperyQKowX0ixdjxdShfFCmqXr8UKqMF5Is3Q9\nXkgVxgtplq7HC6nCeCHN0vV4IVUYL6RZuh4vpArjhTRL1+OFVGG8kGbperyQKowX0ixdjxdS\nhfFCmqXr8UKqMF5Is3Q9XkgVxgtplq7HC6nCeCHN0vV4IVUYL6RZuh4vpArjhTRL1+OFVGG8\nkGbperyQKowX0ixdjxdShfFCmqXr8UKqMF5Is3Q9XkgVxk8Kafv6w4uZbyQipMXGC6nC+Ckh\nvQZ0iGnmWwkIabHxQqowfkJI252QznU9XkgVxl8PabsT0iddjxdShfFzQ/q7tLF36Iilj/vP\ncIFPJULa7vr6iHT1P5hFNPqfxS+Yfv0Cd31tqn1EOvYjpFONvje/YLqQYldDOhDSUKPvzS+Y\nLqTY5K8jCelUo+/NL5gupJiQZmn0vfkF04UU++e+s0FIdacLKfbPfa+dkOpOF1JMSLM0+t78\ngulCiglplkbfm18wXUgxIc3S6HvzC6YLKSakWRp9b37BdCHFhDRLo+/NL5gupJiQZmn0vfkF\n04UUE9Isjb43v2C6kGJCmuW20189ZIchfc113wnpnJCENIuQhoQkpFmENCQkIc0ipCEhCWkW\nIQ0JSUizCGlISEKaRUhDQhLSLEIaEpKQZhHSkJCENIuQhoQkpFmENCQkIc0ipCEhCWkWIQ0J\nSUizCGlISEKaRUhDnw6cfFcs+w4V0jLXfSekc0K6cEghjRPSkJAuHFJI44Q0JKQLhxTSOCEN\nCenCIYU0TkhDQrpwSCGNE9KQkC4cUkjjhDQkpAuHFNI4IQ0J6cIhhTROSENCunBIIY0T0pCQ\nLhxSSOOENCSkC4cU0jghDQnpwiGFNE5IQ0K6cEghjRPSkJAuHFJI44Q01HZI18Z8aUiF7tPI\n9KS6132CG04/5ZBCKvoOvTZGSHWu+wRCGhLShUMKaZyQhoR04ZBCGiekISFdOKSQxglpSEgX\nDimkcUIaEtKFQwppnJCGhHThkEIaJ6QhIV04pJDGCWlISBcOKaRxQhoS0oVDCmmckIaEdOGQ\nQhonpCEhXTikkMYJaUhIFw4ppHFCGhLShUMKaZyQhoR04ZBCGiekISFdOKSQxlUIqcTZhZSa\nPnr6otOFdIGQhoR04ZBCGiekISFdOKSQxglpSEgXDimkcUIaEtKFQwppnJCGhHThkEIaJ6Qh\nIV04pJDGCWlISBcOKaRxQhoS0oVDCmmckIaEdOGQQhonpCEhXTikkMYJaUhIFw4ppHFCGhLS\nhUMKaZyQhoR04ZBCGvePhfS3uLG7k7x5bkqhw9SdXvcwSXWve/KtLn7220O6mY9IFw7pI9K0\nt9rQ2YWUmj56+qLThTTxrTZ0diGlpo+evuh0IU18qw2dXUip6aOnLzpdSBPfakNnF1Jq+ujp\ni04X0sS32tDZhZSaPnr6otOFNPGtNnR2IaWmj56+6HQhTXyrDZ1dSKnpo6cvOl1IE99qQ2cX\nUmr66OmLThfSxLfa0NmFlJo+evqi04U08a02dHYhpaaPnr7odCFNfKsNnV1Iqemjpy86XUgT\n32pDZxdSavro6YtOF9LEt9rQ2YWUmj56+qLThTTxrTZ0diE1NP14g2khzT1MCyEtcvNCZw8J\nqaHpxxsIqcrNC509JKSGph9vIKQqNy909pCQGpp+vIGQqty80NlDQmpo+vEGQqpy80JnDwmp\noenHGwipys0LnT0kpIamH28gpCo3L3T2kJAamn68gZCq3LzQ2UNCamj68QZCqnLzQmcPCamh\n6ccbCKnKzQudPSSkhqYfbyCkKjcvdPaQkBqafryBkKrcvNDZQ0JqaPrxBkKqcvNCZw8JqaHp\nxxsIqcrNC509JKSGph9vIKQqNy909pCQak5Pjinj6p0T0m1nDwmp5vTkmDKu3jkh3Xb2kJBq\nTk+OKePqnRPSbWcPCanm9OSYMq7eOSHddvaQkGpOT44p4+qdE9JtZw8Jqeb05Jgyrt45Id12\n9pCQak5Pjinj6p0T0m1nDwmp5vTkmDKu3jkh3Xb2kJBqTk+OKePqnRPSbWcPCanm9OSYMq7e\nOSHddvaQkGpOT44p4+qdE9JtZw8Jqeb05Jgyrt45Id129pCQak5Pjinj6p0T0m1nDwmp5vTk\nmDKu3jkh3Xb2kJBqTk+OKePqnRPSbWcPCanm9OSYMq7eOSHddvaQkGpOT44p4+qdE9JtZw8J\nqeb05Jgyrt45Id129pCQak5Pjinj6p0T0m1nDwmp5vTkmDKu3jkh3Xb2kJBqTk+OKePqnRPS\nbWcPCanm9OSYMq7eOSHddvaQkGpOT44p4+qdE9JtZw8Jqeb05Jgyrt45Id129pCQak5Pjinj\n6p0T0m1nDwmp5vTkmDKu3jkh3Xb2kJBqTk+OKePqnRPSbWcPCanm9OSYMq7eOSHddvaQkGpO\nT44p4+qdE9JtZw8Jqeb05Jgyrt45Id129lD7IS1wUf7NkJI3X+QuFTp73cOEhBQqNL3KXSl8\nmLpXZpmz1z1MSEihQtOr3JXCh6l7ZZY5e93DhIQUKjS9yl0pfJi6V2aZs9c9TEhIoULTq9yV\nwoepe2WWOXvdw4SEFCo0vcpdKXyYuldmmbPXPUxISKFC06vclcKHqXtlljl73cOEhBQqNL3K\nXSl8mLpXZpmz1z1MSEihQtOr3JXCh6l7ZZY5e93DhIQUKjS9yl0pfJi6V2aZs9c9TEhIoULT\nq9yVwoepe2WWOXvdw4Suh7R9cfpzIUKqJXmYuldmmbPXPUzoakjbtx+2x1+UIaRakoepe2WW\nOXvdw4SEFCo0vcpdKXyYuldmmbPXPUxo2udIQpo3vcpdKXyYuldmmbPXPUxobkh/5ytzL5N6\nOCOj76amDnMiFdLhSYZyH5EWuSg9nJE+PrSHFnho1/5FEdJSmnp/pDZGSO2ckX85pPLP2rV/\nUYS0lKbeH6mNEVI7Z+RfDqn8dza0f1GEtJSm3h+pjVnge+3avyhCWkpT74/UxgipnTMipIz2\nL4qQltLU+yO1MUJq54wIKaP9iyKkpTT1/khtjJDaOSNCymj/oghpKU29P1IbI6R2zoiQMtq/\nKELim5BuvyhC4puQbr8oQuKbkG6/KELim5BuvyhC4puQbr8oQuKbkG6/KELim5BuvyhC4puQ\nbr8oQuKbkG6/KELim5BuvyhC4puQbr8oQuKbkG6/KELim5BuvyhC4puQbr8oQuKbkKCI1FYL\nCWKprRYSxFJbLSSIpbZaSBBLbbWQIJbaaiFBLLXVQoJYaquFBLHUVgsJYqmtFhLEUlstJIil\ntlpIEEtttZAgltpqIUEstdVCglhqq4UEsdRWCwliqa0WEsRSWy0kiKW2WkgQS221kCCW2moh\nQSy11UKCWGqrhQSx1FYLCWKprRYSxFJbLSSIpbZaSBBLbbWQIJbaaiFBLLXVQoJYaquFBLHU\n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\n4H//UhzYlCkIxQAAAABJRU5ErkJggg==",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(model_data, aes(x = unit_price)) +\n",
    "  geom_histogram(bins = 30) +\n",
    "  labs(\n",
    "    title = \"Distribution of Unit Price\",\n",
    "    x = \"Unit Price\",\n",
    "    y = \"Frequency\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 50,
   "id": "5f9f5e48-496c-4a53-affa-1cedf1b3c159",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAANlBMVEUAAABNTU1ZWVloaGh8\nfHyMjIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD///8jvLTkAAAACXBIWXMA\nABJ0AAASdAHeZh94AAAfPUlEQVR4nO3diXbiSBJGYWnAxgt2wfu/7ABikzJRx28FSS73O2e6\n2kspJBS3jZep6vYAFutefQJADQgJcEBIgANCAhwQEuCAkAAHhAQ4ICTAASEBDggJcPD3kLpB\n//5zfnH85t376H0j7zF6xwdvfGz33nWru5e/3g4n8/Y9+zvEEWPn6+1Wm138yPIloCKLQzrY\nDC9O3zx94cGiDa+Wt/DYzfr60k9/Ppf149+xcNFv19tPS/rjJaAiS0I6/fL72XUfj988+5q5\nV//3+J/bCz+HD0bbw6/bdfc28zv+NGj62w8zNr5HRgUWh3Ta4uDJToqQ7l5YdZ/nf1t3D5/d\nOYV0uN7e98iogENI+83xQ9Lw4s/78bOm7fmJ0PGX3erwQeLy1O6j79bfd7/58Mv1HffD7+8v\nn3UdXrPpu9V9F7e3duffNvi+fRz6OX64uB09PKPpjI9hxufhlyHGw0ec60meTj643vO/bVaH\nd9zu96NLGJ3197rrPyengTp5hPRz3LbTi9vzZxHft+V6O34Odd6xzfVTqgchfV9///E16+u/\nD+7eOg7pbfJh6C6k4IwmMz5O/759P/1yLOnr9nnf+eSn13v+iNSPT+Ya0u2sh2NvxqeBOnmE\ntL+u0ar72h93cXX7BHy92193rD+89bs/fnJzt+p3n6kfniR+7Pa7w+r9nt59u9+93b58MHrr\n6OlUP3lueXf04IymM76PH1H74ZfV8c3HDzI/6yGQ9S446H7bn+L6OH1m+HE6vbtLuDvrw6Th\nesengSr5hjR53fGf2+sLp70Kn3zdbeHm/N//9+Fdjv/53t0/g7x76yikB18xvHvKeHttfMb1\n+eZmaHI3fJDdjg56cUp7Nbzj3WWf//V61pvhE7evyWmgSr4hvR0+D/j6vXvz/Wcrl69J3D46\nTENadcPv/Z28y2D0VmtIwRlNZuwm77+65jI97OX1q8vXNfY/3x/rMKS7Q52bHJ8GquQTUn9+\n8be/rlospNtvjId0PeTkXSYDpx/8Lis7PbXjL4/OKDZjeM3jkA7/2PXXT3M+++snavGQ7q/3\n7jRQJY+QttcvNhw+JTh92v4xWdsnh/R+/0n87+S3xs/ocUixK7y9tL083/s8PMXbfP0aQ7o7\nDVTJI6TN8ZOf24s/79ePUPGndg9D+utTu7svf//26/C33p/RzIzjL/3d93ljIe0/zj/YsBp9\n9jf51+Cp3d1poEoOIQ1fDp7+pzwW0umZzbZbX6L6nrzjpht+HO59+s2gk9Fbx1veD1/HOD2F\n+h4dPTijmRnHX96HN/906wchHfq4+8m675mQzl9s+JycBqq0OKTjjwhdPwMZvsq7GZ7q3X2R\n+rxjx7d+9cf/lK+7t935K8N373h4orQZvjT9Ewlp9NbxTm6HHxHaHT5vOX5sujt6cEYzM46/\n/Jy+c/Rz7jFyvcf3+Nmff5himHF/CeNDfQ3flxqdBqq0JKSL2w+tnr/v2P8OX/6ahvRxffft\n7XuV9+84/mbp7bcO7t862fLLm4ZNvTt6cEYzM+7fHHzQu730fnpq+XmZuB1dwv2hPm5ft7g7\nDVRpcUirzf3/jWJ7+kmY47r8rG6fl1x37PgjQsPn6tvDmz+G/3Dfv+P4x3fufpm+dfosaXf8\nSnT3fv6iw+3owRnNzBh++d1cflroQUiHJ5LHN38ej7I9fXp2dwmjQ32vjx8pJ6eBKvGk/dl2\nPJ9rASE9zfCTHNt1x3ePGkBIT3P5FGnm/2uIahDS83yf/l+8X68+DaRASIADQgIcEBLggJAA\nB4QEOCAkwAEhAQ4ICXBASICDpCH9Szks/Twur+F5hFTsOC4vp3mEVOw4Li+neYRU7DguL6d5\nhFTsOC4vp3mEVOw4Li+neYRU7DguL6d5hFTsOC4vp3mEVOw4Li+neYRU7DguL6d5hFTsOC4v\np3mEVOw4Li+neYRU7DguL6d5hFTsOC4vp3mEVOw4Li+neYRU7DguL6d5hFTsOC4vp3mEVOw4\nLi+neYRU7DguL6d5hFTsOC4vp3mEVOw4Li+neYRU7DguL6d5hFTsOC4vp3mEVOw4Li+neYRU\n7DguL6d5hFTsOC4vp3mEVOw4Li+neYRU7DguL6d5hFTsOC4vp3mEVOw4Li+neYRU7DguL6d5\nhFTsOC4vp3mEVOw4Li+neYRU7DguL6d5VYT0v//2pMkjZd353McVNo+Q/JR153MfV9g8QvJT\n1p3PfVxh8wjJT1l3Pvdxhc0jJD9l3fncxxU2j5D8lHXncx9X2DxC8lPWnc99XGHzCMlPWXc+\n93GFzSMkP2Xd+dzHFTaPkPyUdedzH1fYPELyU9adz31cYfMIyU9Zdz73cYXNIyQ/Zd353McV\nNo+Q/JR153MfV9g8QvJT1p3PfVxh8wjJT1l3Pvdxhc0jJD9l3fncxxU2j5D8lHXncx9X2DxC\n8lPWnc99XGHzCMlPWXc+93GFzSMkP2Xd+dzHFTaPkPyUdedzH1fYPELyU9adz31cYfMIyU9Z\ndz73cYXNIyQ/Zd353McVNo+Q/JR153MfV9g8QvJT1p3PfVxh8wjJT1l3Pvdxhc37a0j/cmII\n6dWniCotD+lv9T3puHxEqnBcYfMIyU9Zdz73cYXNIyQ/Zd353McVNo+Q/JR153MfV9g8QvJT\n1p3PfVxh8wjJT1l3Pvdxhc0jJD9l3fncxxU2j5D8lHXncx9X2DxC8lPWnc99XGHzCMlPWXc+\n93GFzSMkP2Xd+dzHFTaPkPyUdedzH1fYPELyU9adz31cYfMIyU9Zdz73cYXNIyQ/Zd353McV\nNo+Q/JR153MfV9g8QvJT1p3PfVxh8wjJT1l3Pvdxhc0jJD9l3fncxxU2j5D8lHXncx9X2DxC\n8lPWnc99XGHzCMlPWXc+93GFzSMkP2Xd+dzHFTaPkPyUdedzH1fYPELyU9adz31cYfMIyU9Z\ndz73cYXNIyQ/Zd353McVNo+Q/HhenuGS/kdIGc0jJD+E1PA8QvJDSA3PIyQ/hNTwPELyQ0gN\nzyMkP4TU8DxC8kNIDc8jJD+E1PA8QvJDSA3PIyQ/hNTwPELyQ0gNzyMkP4TU8DxC8kNIDc8j\nJD+E1PA8QvJDSA3PIyQ/hNTwPELyQ0gNzyMkP4TU8DxC8kNIDc8jJD+E1PA8QvJDSA3PIyQ/\nhNTwPELyQ0gNzyMkP4TU8DxC8kNIDc8jJD+E1PA8QvJDSA3PIyQ/hNTwPELyQ0gNzyMkP4TU\n8DxC8kNIDc8jJD+E1PA8QvJDSA3PIyQ/hNTwPELyQ0gNzyMkP4TU8DxC8kNIDc8jJD+E1PA8\nQvJDSA3PIyQ/hNTwPELyQ0gNzyMkP4TU8DxC8kNIDc8jJD+E1PA8QvJDSA3PIyQ/hNTwPELy\nQ0gNzyMkP4TU8DxC8kNIDc8jJD+E1PA8QvJDSA3PIyQ/hNTwPELyQ0gNzyMkP4TU8DxC8kNI\nDc8jJD/my7NU0mZIr7yThERISRDSHELyQ0iLvfJOEhIhJUFIcwjJDyEt9so7SUiElAQhzfnv\n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\nybKdinFIT/y7kY4ICbmwbKeCkNAky3Yq+MkGNMmynQpCQpMs26kgJDTJsp0KQkKTLNupICQ0\nybKdCkJCkyzbqSAkNMmynQpCQpMs26kgJDTJsp0KQkKTLNupICQ0ybKdCkJCkyzbqSAkNMmy\nnQpCQpMs26kgJDTJsp0KQkKTLNupICQ0ybKdCkJCkyzbqSAkNMmynYq/hvTPx6sfTrTKZ3+X\nh/S3+oLXvPrhRKss26kgJDTJsp0KQkKTLNupICQ0ybKdCkJCkyzbqSAkNMmynQpCQpMs26kg\nJDTJsp0KQkKTLNupICQ0ybKdCkJCkyzbqSAkNMmynQpCQpMs26kgJDTJsp0KQkKTLNupICQ0\nybKdCkJCkyzbqXhiSK9+qIDHwn0lJEAW7ishAbJwXwkJkIX7SkiALNxXQgJk4b4SEiAL95WQ\nAFm4r4QEyMJ9JSRAFu4rIQGycF8JCZCF+0pIgCzcV0ICZOG+EhIgC/eVkABZuK+EBMjCfSUk\nQBbuKyEBsnBfCQmQhftKSIAs3FdCAmThvhISIAv3lZAAWbivhATIwn0lJEAW7ishAbJwXwkJ\nkIX7SkiALNxXQgJk4b4SEiAL95WQAFm4r4QEyMJ9JSRAFu4rIQGycF8JCZCF+0pIgCzcV0IC\nZOG+EhIgC/eVkABZuK+EBMjCfSUkQBbuKyEBsnBfCQmQhftKSIAs3FdCAmThvhISIAv3lZAA\nWbivhATIwn0lJEAW7ishAbJwXwkJkIX7SkiALNxXQgJk4b4SEiAL95WQAFm4r4QEyMJ9JSRA\nFu4rIQGycF8JCZCF+0pIgCzcV0ICZOG+EhIgC/eVkABZuK+EBMjCfSUkQBbuKyEBzyBtOyEB\ncdK2ExIQJ207IQFx0rYTEhAnbft/h9Qf3P9KSGiDb0j9+R/99QVCQhMICXDgG9KlJkJCY5KE\n9O+/vfpxABYx7LgYUr/nIxKaoyw7IQEPuIfUj/9BSGiCd0j9pCZCQhOcQ+rvfiEktMM3pL4/\n/0gDP9mAtviG9HevfhyARaRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQg\nTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSck\nIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtp2QgLipG0n\nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRt\nJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKk\nbSckIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtp2QgLi\npG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC\n4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZC\nAuKkbSckIE7adkIC4qRtJyQgTtp2QgLipG0nJCBO2nZCAuKkbSckIE7adkIC4qRtJyQgTtr2\nv4b077+9+nEAFjHs+PKQDF79OACLSNtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTthATE\nSdtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTthATESdtOSECctO2EBMRJ205IQJy07YQE\nxEnbTkhAnLTthATESdtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTthATESdtOSECctO2E\nBMRJ205IQJy07YQExEnbTkhAnLTthATESdtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTt\nhATESdtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTthATESdtOSECctO2EBMRJ205IQJy0\n7YQExEnbTkhAnLTthATESdtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTthATESdtOSECc\ntO2EBMRJ205IQJy07YQExEnbTkhAnLTthATESdtOSECctO2EBMRJ205IQJy07YQExEnbTkhA\nnLTthATESdtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTthATESdtOSECctO2EBMRJ205I\nQJy07YQExEnbTkhAnLTthATESdtOSECctO2EBMRJ205IQJy07YQExEnbTkhAnLTthATESdtO\nSECctO2EBMRJ205IQJy07faQ+gNCQjueE1J//QchoQmEBDggJMBBkpD+AVge0p/8++93cZV4\nHpfX8DxCKnYcl5fTPEIqdhyXl9M8Qip2HJeX0zxCKnYcl5fTvCf+ZEOorIcm93FcXk7znviz\ndqGyHprcx3F5Oc0jpGLHcXk5zSOkYsdxeTnNI6Rix3F5Oc0jpGLHcXk5zSOkYsdxeTnNI6Ri\nx3F5Oc0jpGLHcXk5zSOkYsdxeTnNI6Rix3F5Oc0jpGLHcXk5zSOkYsdxeTnNI6Rix3F5Oc0j\npGLHcXk5zSOkYsdxeTnNI6Rix3F5Oc0jpGLHcXk5zSOkYsdxeTnNI6Rix3F5Oc0jpGLHcXk5\nzSOkYsdxeTnNI6Rix3F5Oc0jpGLHcXk5zSOkYsdxeTnNI6Rix3F5Oc0jpGLHcXk5zSOkYsdx\neTnNSxoSUCtCAhwQEuCAkAAHhAQ4ICTAASEBDggJcEBIgANCAhykDWnpX4ueM4e/9T1ndV/e\ncGlLrjFpSNXfinqvr+7L62+X99drTBlSX++dqH3T6r68fl9USH29d2Jf9aUdVR3SnpDy0e/r\n/ySi3usrKaR+X/OdGJ5mV319bfx3IvuQKv9PWu3X18zl5R/SINW45JrZtCoVFNJJvXeinU2r\nEiFlo5lNqxIh5aPqJ661X15hP9kA1IqQAAeEBDggJMABIQEOCAlwQEiAA0LKXnf2th29+rM/\nve0154QpbkT2uqvt+NV7QsoHNyJ751h2m24VeTXywN3I3rWY079s37qu3wwfp4ZXdd3v2+lV\n+/3vult9U9gr8KBnb/QR6Xt4krcZhdQPr9rv+uGtLz7hJvGgZ2/0OdKq+9rvfy4NnUNa7/af\nXb/ff3Tr/W5NSK/Ag569S0bvP6cXf78/1pOQfs//tjr+2y8hvQIPevZOYXwfPticrC/P3u5C\n2gf/htR40LM3hLEZSnrvVp/fv4SUHR707J3DWHUflxd2D0Liqd3r8KBn7xzGT9f9HF/Ynr+e\nEAnp9FGLLza8BA969i5hfBy//L3pbp8j9dOQ+PL36/CgZ+8axunJ3XvXrbfHV32GIZ2+IftF\nSK/Ag16druI/pCRfhFSR07dsN937q8+jRYRUkfMnUL+vPo8WEVJNPldd905Hr0BIgANCAhwQ\nEuCAkAAHhAQ4ICTAASEBDggJcPB/1II1ligZLHAAAAAASUVORK5CYII=",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(model_data, aes(x = rating)) +\n",
    "  geom_histogram(bins = 20) +\n",
    "  labs(\n",
    "    title = \"Distribution of Customer Ratings\",\n",
    "    x = \"Rating\",\n",
    "    y = \"Frequency\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 51,
   "id": "5cd4e3a0-2fe1-4159-922f-16f49f6f3e47",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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\nhARM4D9Wf/1eXsKqVQAAAABJRU5ErkJggg==",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(\n",
    "  model_data,\n",
    "  aes(x = customer_type, y = quantity)\n",
    ") +\n",
    "  geom_boxplot() +\n",
    "  labs(\n",
    "    title = \"Quantity Purchased by Customer Type\",\n",
    "    x = \"Customer Type\",\n",
    "    y = \"Quantity\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 52,
   "id": "a512a223-3a0c-446b-b25e-8fb8da527dde",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAANlBMVEUAAAAzMzNNTU1oaGh8\nfHyMjIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD////agy6EAAAACXBIWXMA\nABJ0AAASdAHeZh94AAAfZUlEQVR4nO3di1biiBKF4XRAURGbvP/LTiBcQom36VR23PV/ax21\n0YZQ5T9cz0zTAfhnjfoAAAeEBEyAkIAJEBIwAUICJkBIwAQICZgAIQETICRgAoQETODfQ2qa\n91+N/rx/vDllsH6+ewZfX8QHXh76M33YfvITN4fxY83Iv5wPbKWHdHPi9ddxfe8Mvr6Iu3bt\n+zP94Vl8eQCEhE9lhvT+xPMfXtvm+c7Pfn0R9+z6G6PXw5mum4f/eRYTHAVq04TUvX526/H5\nebyzukS5bj68d0dISDV5SP2HTdustqc/394buv3Zptmv+huR04nbddM87o9f9rctzXrURP8T\nT+3xlH2zGk66fNFtr7dDu2ZzuYzjp91j07SPr6PD2D22/Sm767kejvS5//QcLvl0cO+v6M0h\n9Kc9t5djjceNOhJCWh9/a7ffCemh6X/1hxM3x59sD1++DA9GNqO/tjmfsjnd6Lw0T6dvPoSb\noVFIr6eHNdvLYWwvpxx+4un49evj8dPz7SWfDu7OFR0fwvk8NnePG3UkhNS+dvuHw123e082\nnL7YDt9f788n7pp22+3Xh9/CXbPub0N2o/tp/Xm+9H+nbXbd2+n2YN28nb7ZNvt7x3P4tGr6\nv9b/fq/Op/YPp5723b7P8u14rttDFu3waXV7yaeDu3Pw40MYHdmd40YdCSEdfo/2wy1O90FI\n/W/e8Xf19XLi4/EW4Xi3aTOUsb/esWqOQQz33B5O57+K5xn+fDmA8amb083F43Af8HSk2/MP\njC/5dHD3rujoEJpTz+3m3nGjjozHSOevP3v6e3P7o/2Nx+Wf/6t3zzQ3p28OtxqH39PrPbvP\nQnroHw69vI1OXZ1+79+GCPbh58eX/P6phcspo0M4P2fysLp33KhDElL7sO1uf/T2xuN9SKPP\nD4e7Udd7duMExz98+PR2fIHp+DzCcOrlLEep3Bzwt0IaHcL5hnHV3Dtu1DF3SHf+5vuQPrqI\n06Oph/E9u/5u2ugxyVvoY3t8IuHp2yF9dKi3p1wP4Xwc67vpoY5/X/662Q1f7I73c/5nSKOn\nDNrzGY5+cD/6C/1Nweie3fjp77d2Hfs4PgXefnDXLh7F+JI/C+l6COfLPty1e3/cqOPfQ9o0\nj+cvwgOfn4T0eHoA3x6+PJ7h7vqa7fDc9PlV3G2zGd2zO/wCvwxfvJ2ewtgff+j2Ju78ZMNw\nrI/xBafh0/iSPw3pcginxPeHJxveHzfq+PeQ9k3z2P9OvW2GX6r3IY1+5z8Oadu0u8vT38eP\n7fjp70MrL+3pibRVO7pnd3y16PAWof1ze7x9WDcP+8PTgs356e/N8CTc4TDe+rMenv7e3Qtp\nfMmfhnQ5hOEp9O3x9vT9caOOCe7Xn1/kbOIzCKen4z58+HPzmzy85LoeneH4Bdmn8SnbZnTP\nbnwAx/tZw6uwm8O5nl6Qbd8uh3H7guy7oxhd8uchnQ/h+LLt+aq/O27UMcUD5N2m/zVdbcbP\nM19D2q2GtyuMv3n7p9On5/4HT7+Db5vLe3bOP3F4i9D5hZ39za3c4YSnw7spHs9v1OnP6Gk4\n19fjW4TeRodx+xahd5+ul/x5SOdD6E/rk33c3T9u1PEbn2l6vrlnJz0EnqnD4Bf+Iuzad286\nkB0CIWHw634RFvAoZHQIhITBr/tFWOkfhYwOgZAw4BcBmAAhARMgJGAChARMgJCACRASMAFC\nAiZASMAECAmYACEFf9UH4Mx4uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY\n71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiE\nFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94\nuIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9a\nz3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i43wmpHT72xp9NGe9az3i43wjp1M/pw/UPnox3\nrWc83K9DajtCwjSMh/vtu3aEhH9mPNx/DekvUNd0Idn5oz4AZ8bDJaTAeNd6xsMlpMB413rG\nwyWkwHjXesbDJaTAeNd6xsPlnQ2B8a71jIfLe+0C413rGQ+XkALjXesZD5eQAuNd6xkPl5AC\n413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+X\nkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZ\nD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd\n6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC\n413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+X\nkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZ\nD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd\n6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC\n413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+X\nkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZ\nD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd\n6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC\n413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ/3X0P66+aP+gCc2Q13upDsGP9DU894uIQU\nGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4\nhBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rP\neLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjv\nWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQU\nGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4\nhBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rP\neLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjv\nWs94uIQUGO9az3i4hBQY71rPeLgLC+kPeuotpPG9ZosLSX0AS+A7BN9rRkgL5DsE32tGSAvk\nOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZI\nC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZIC+Q7BN9r\nRkgL5DsE32tGSAvkOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZIC+Q7BN9rRkgL5DsE\n32tGSAvkOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvk\nOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZIC+Q7BN9rRkgL5DsE32tGSAvkOwTfa0ZI\nC+Q7BN9r9v2Q2qPzF1mHYzzp7/Mdgu81++EtUnv6XxrjSX+f7xB8r9nPQmovH7IYT/r7fIfg\ne81+HlJqR86T/j7fIfhesx+FNNwg3T5E+jst40l/35+Jh7ocdtfsurSfh3T5kIGQOuch+F6z\nn4cUvpqY8aS/z3cIvtfsJyG1d7+clvGkvy9pCH9wkDPcn4fEXbt0WSHlnO0vs6iQ8p65Y9kd\nIaVaTEhd5hsbWPYBISVaQEhzYNkdIaUipDoIKREh1UFIiQipDkJKREh1EFIiQqqDkBIRUh2E\nlIiQ6iCkRIRUByElIqQ6CCkRIdVBSIkIqQ5CSkRIdRBSIkKqg5ASEVIdhJSIkOogpESEVAch\nJSKkOggpESHVQUiJCKkOQkpESHUQUiJCqoOQEhFSHYSUiJDqIKREhFQHISUipDoIKREh1UFI\niQipDkJKREh1EFIiQqqDkBIRUh2ElIiQ6iCkRIRUByElIqQ6CCkRIdVBSIkIqQ5CSkRIdRBS\nIkKqg5ASEVIdhJSIkOogpESEVAchJSKkOggpESHVQUiJCKkOQkpESHUQUiJCqoOQEhFSHYSU\niJDqIKREhFQHISUipDoIKREh1UFIiQipDkJKREh1EFIiQqqDkBIRUh2ElIiQ6iCkRIRUByEl\n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\nCKkOQkpUJST0kmabc7a/TJGQ9Hx/3Xyv2U8Q0kx8f918r9lPENJMfH/dfK/ZTxDSTHx/3dSP\n/BYiabqEFPiGtADGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMl\npMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rG\nwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjX\nesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTA\neNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMl\npMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rG\nwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjX\nesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbDJaTAeNd6xsMlpMB413rGwyWkwHjXesbD/X5I\nbe/8uU07HjnjXesZD/fbIbXnD8YRHRjvWs94uIQUGO9az3i4P3uM1Np35LxrPePh/jyk24dI\nf938UR+AM7vh/s+QLvfsjG+WjP+hqWc83B+HdPuFH+Nd6xkP9ychtXe+smO8az3j4f4gpPb6\nkZDwfxgP9wcvyF4/GXfkvGs94+F+/3Wk89N13m9scN61nvFwea9dYLxrPePhElJgvGs94+ES\nUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j\n4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxr\nPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJg\nvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ES\nUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j\n4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxr\nPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJg\nvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ES\nUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j\n4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxr\nPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJg\nvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePhElJgvGs94+ES\nUmC8az3j4RJSYLxrPePhElJgvGs94+ESUmC8az3j4RJSYLxrPePh/mtIf938UR+AM7vhTheS\nHeN/aOoZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZ\nD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd6xkPl5AC413rGQ+XkALjXesZD5eQAuNd\n6/39+kd+K0IKCCkRIdVBSIkIqQ5CSkRIdRjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94\nuIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9a\nz3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY\n71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiE\nFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQUGO9az3i4hBQY71rPeLiEFBjvWs94\nuIQUGO9az3i4hBQY71rPeLiEFBjvWs94uIQETICQgAkQEjABQgImQEjABAgJmAAhARMgJGAC\nhARMgJCACRQNqQ2fP/o+/p/25tO3fvaXqxpSO/505/vzHYql83y/9bOpRzIXQrr//fkOxVI7\nTJCQ3A2LPn1s29MfDp9v/nDzTeHh/jqjkMYTvJnx9TsOCOm88WGp7fgP4Zv4ttPo7o83fkd3\nmBMipJt9xj94LXs+d0I6fR5/6IxmWzakS0VtO9zFuB/S+Jv4tmtFn4XkNFtCunkm/KNbIo9l\nz+c0v89DGt9m/XqEREgJvhOS193muiF9eife8wHxfIZ5tV+GxF27X64d/2/0LOx1yY5P0c6n\nvX66N97Ld3z+IVU0JGBahARMgJCACRASMAFCAiZASMAECAmYACEtwfO6adYvH33zxy+0NBf/\neFz4Nkat99YOv/Xr+9/+eQ6END9Grdc2j29dt22b57vf/n85ENG8GLfcS/Nw/Lxt2vPv//Hj\nU9usnoebl/5Pb4/NsbfD9x76v/G2ah72/R/3h9P3x9N37eg2bTijfbM6fzr+vfVbN/47mAwh\nyT00r8MXu24c0uZ43+z5FNL+ePev3R++99B/9bLqPzx2h5uz3ur4d9bHE05Ot0ibZtsdWn3q\nT3g8ncP172AyhCR3cyfsGlLTvHWvlxupzeER1LrZHP742IfRf/Vy+MbT4aRNc7zl2tw5193x\nkdeh1T60/XAO17+DyRCS3Ach9Y+ctteTVn1W3dvhZuQQWP9hP3xjNfz8w+n09+f60PQ3dEOP\nu9M5XP8OJkNIch+EtO3vgK3ezieNb6nGp12fngvPLpz/uOuD2R7u843Pgaf0Jsc05S6PkbrX\nmycbut2qaV//NaTDbdnxgRIhpWKacudn7V7b8+3G2/mX/PlSyPiuXTf6sLos8KOQts2mHX76\neA7r8d/BZJip3uV1pN3h65duvx4eI73298vuPdnQjT5sDie9HL75UUh9N8cnHA4f+3N+Gv8d\nTIaQ9N5Ww12tw7Nuxye9n65Pfz8dCmhvn/7uRh+G049PKHwU0rZpXrrh6fHjWY3+DiZDSEuw\nfWzP77Xr74c9nW6E2qbtO+rv3x1++8cvyI4/HE5fv3afhHR6Pq//uB7O4fp3MBlCsvc6vPbK\nkwupmK699fHNDYSUi+mau7yrnJBSMV1z7fkdDISUiukCEyAkYAKEBEyAkIAJEBIwAUICJkBI\nwAQICZjAf0B+IeHNrUsRAAAAAElFTkSuQmCC",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(\n",
    "  model_data,\n",
    "  aes(x = customer_type, y = unit_price)\n",
    ") +\n",
    "  geom_boxplot() +\n",
    "  labs(\n",
    "    title = \"Unit Price by Customer Type\",\n",
    "    x = \"Customer Type\",\n",
    "    y = \"Unit Price\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 53,
   "id": "72037a91-c825-473d-8077-f3a0288ec78f",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAANlBMVEUAAAAzMzNNTU1oaGh8\nfHyMjIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD////agy6EAAAACXBIWXMA\nABJ0AAASdAHeZh94AAAfZElEQVR4nO3di1biCrNF4XRAUbk0vP/L7oQEKnjp7SUVlqvmN8bR\nblQkVczm+u/TnAD8WHPvCwA4ICRgBoQEzICQgBkQEjADQgJmQEjADAgJmAEhATMgJGAGPwrp\n5aFpmoftP77j+PiT8z81o9Xm+P45N/97+f/3O7IPopn4yflA2g92u2/Hq8f6H2f/s+tOXAXb\n1yUN5/zjkPIPgpBK+P5u992/47vu827dPHx89j8Nafjc/Y7NN8/539+3xEHMdBaQ9v0Fr5rn\n8U/r5sM7RjOF1F3h22+e87+/b4mDmOksIO3bC97GP+H7/uZivKqcP+0fu/tij7vxbs35Wx7b\n7pT9+B1PbbPqrrbP3afhetzdIDTr7fDV4yrOOa5/4582q+4bd6frOZ9P7j5shnPsL9e6aZ9v\nf7D7df2ZH5vVcNL1D8scxOTi31yE7rTndvyJ6U/jN/p2SA+v/gWfXAd34yOC7fU6uL2e0n/H\n0/nPu8fzp/5K+DJ8dXP+6kMTd+Ne3yK117O5DWl9PffhvDfTkDaXM9+MF/mleVryIKYHMr0I\nl/PYnG5/Gr/Rt0Nqm9uH/5Pr4Kp5OfVXjdXl1O6RyNPxdOyu0Yf+pHbbX6Pa4dOq/3J/I7Nf\nD4Gsj2/O9LRrz1exp3MBT+cnBiZPNnTnuDsdH/qTu9/U/e5tOw2pHU7Znw7j7cG6vxjLHcT0\nQKYXYXLJbn4av9G3Q3p9r39yHZx8afjjZvyX9nG4+9RfWY7Dp/M3bIar87G/N9T9I39zphfn\nJ9VWwzde7s/FH8dz7M/qfDfrZRpSH8Rwz+1h/MZVfHGBg7j5RZOL0Iw9t5vbn8ZvlBHSQ/dI\n4uUwOXU1XmUOw/Xn+Or7V5Onh2/P9nL66vKUwGm/fVq/DWlyVuMVchLScOMw3Gr019O4Z7fM\nQdz8oslFuDzj/rC6/Wn8Rt9e3Orje0WH9nrlf/Vqz+RadvOP/8chdR+O7fUOz3N7vba9H9Ll\nx988SzF8fujvRsU9u2UO4vbyxEW43DCuXv00fqNvL+5xenf+8OqqtT0/Bn/69HVwcnnehtQ/\n7h/uKj13d/E2L4fvh9TfHkzu2S1zELenxEW4XI71u+nhd/n2AifPHB/a9eur1vnZ4/aDe0XT\nb+w/nR9uXy7POyGdnsY3NqyGoL531+58SndTMLlnt8xBvDrlehEuv7u/azf9afxG3/+XsB0e\nxZ/vBG0vV9jtq8fol8fpw7vVHl+/VjN8ehy+vG/WH4TUXYkn76zb/iOk8cmG52lI51N2wyOS\nbbOZ3LNb5iCmBzK9CGPix/7JhulP4zf6fki74d01x+5xS/9P67p5OI7POw/PHG+G56/6q0x3\nZ2wzPHO8f+86uD+/frIfr8o3l2782/78k8P7EMbntpvxyvjmrF6GF2XiLM6ntOO9w1U7uWe3\nzEFMD2R6EYan0Lfnp+CnP43f6Af3zS8vUA53UXbxSuj4WmZ7GJ6NOr1+LXP4xZNP2+lrmTeX\n7vK3x/N17/nyG3eXc34d0viC7E1Ik5c9z7/qafobFjiI06tTLhfh/LLteH7Tn8Zv9JMHucf+\nmejm8fIel1XTPg3XmN353TX9P+P71fCWhNt317z5dNhc3mjzQUjdfbD+y8/9uezOj2yGc34T\nUv8Woe5G5ubJhv4tQpcXdo7N9J7dIgfx+pTLRehO65J9HB8cxU/jN/J8tujjFzafb+7Z3cXl\nIvBMnROzZQ7vY9itmw/+bd+3b950sLTrRSAkJ2bLvDxEev/JL4FHIZOLQEhO3Ja57R/Ar1/e\n/+Lq/o9CJheBkJywTGAGhATMgJCAGRASMANCAmZASMAMCAmYASEBMyAkYAaEFP7e+wKYs54v\nIQXrRQuwni8hBetFC7CeLyEF60ULsJ4vIQXrRQuwni8hBetFC7CeLyEF60ULsJ4vIQXrRQuw\nni8hBetFC7CeLyEF60ULsJ4vIQXrRQuwni8hBetFC7CeLyEF60ULsJ4vIQXrRQuwni8hBetF\nC7CeLyEF60ULsJ4vIQXrRQuwni8hBetFC7CeLyEF60ULsJ4vIQXrRQuwni8hBetFC7CeLyEF\n60ULsJ4vIQXrRQuwni8hBetFC7CeLyEF60ULsJ4vIQXrRQuwni8hBetFC7CeLyEF60ULsJ4v\nIQXrRQuwni8hBetFC7Ce72dCaoePndzLcm/WixZgPd9PhDT0Ex9sWS9agPV8/z+k9kRImIP1\nfD99146Q8EPW8/1uSH8N/bn3BTBnON+fh+Toz70vgDnr+RJSsF60AOv5ElKwXrQA6/kSUrBe\ntADr+RJSsF60AOv58s6GYL1oAdbz5b12wXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqzn\nS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetEC\nrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF6\n0QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tI\nwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqzn\nS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetEC\nrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF6\n0QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tI\nwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqzn\nS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetEC\nrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF6\n0QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tI\nwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqzn\nS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetEC\nrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF6\n0QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tI\nwXrRAqzn+92Q/hr6c+8LYM5wvj8PyZH1v5gCrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdL\nSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs\n50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrR\nAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jB\netECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdL\nSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs\n50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrR\nAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXrRAqznS0jB\netECrOdLSMF60QKs50tIwXrRAqznS0jBetECrOdLSMF60QKs50tIwXnRfzDIGjAhBeuQ7n0B\nRBDSApyvbM7H9hWEtADnK5vzsX0FIS3A+crmfGxfQUgLcL6yOR/bVxDSApyvbM7H9hWEtADn\nK5vzsX0FIS3A+crmfGxfQUgLcL6yOR/bVxDSApyvbM7H9hXuId37jSM6sgacdL6/jX1I974A\nKggpFyEVQUi5CKkIQspFSEUQUi5CKoKQchFSEYSUi5CKIKRchFQEIeUipCIIKRchFUFIuQip\nCELKRUhFEFIuQiqCkHIRUhGElIuQiiCkXIRUBCHlIqQiCCkXIRVBSLkIqQhCykVIRRBSLkIq\ngpByEVIRhJSLkIogpFyEVAQh5SKkIggpFyEVQUi5CKkIQspFSEUQUi5CKoKQchFSEYSUi5CK\nIKRchFQEIeUipCIIKRchFUFIuQipCELKRUhFEFIuQiqCkHIRUhGElIuQiiCkXIRUBCHlEgip\n7WRdCvZ8QUi57h9Se/2QgT2PCCkXIRVBSLkIqQhCyiUX0t95sefRn5kHy4BvzTzfOGOebNDC\nLVIuuVukmbHnESHlIqQiCCkXIRVBSLkIqQhCynX/kHiyYRGElEsgpFTseURIuQipCELKRUhF\nEFIuQiqCkHIRUhGElIuQiiCkXIRUBCHlIqQiCCkXIRVBSLkIqQhCykVIRRBSLkIqgpByEVIR\n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\nxnkQzsdGSGKcB+F8bIQkxnkQzsdGSGKcB+F8bIQkxnkQzsdGSGKcB+F8bIQkxnkQzsdGSGKc\nB+F8bIQkxnkQzsdGSGKcB+F8bIQkxnkQzsdGSGKcB+F8bIQkxnkQzsdGSGKcB+F8bIQkxnkQ\nzsdGSGKcB+F8bIQkxnkQzsdGSGKcB+F8bIQkxnkQzsdGSGKcB+F8bIQkxnkQzsdGSGKcB+F8\nbIQkxnkQzscmExJG995EIudjUwlJgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC\n9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+X\nkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVY\nz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWi\nBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC\n9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+X\nkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVY\nz/e7If019OfeF8Cc4Xx/HpIj638xBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIF\nWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1\nogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQ\ngvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjP\nl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIF\nWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1\nogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQ\ngvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjP\nl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIF\nWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1\nogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQ\ngvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjP\nl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIF\nWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1\nogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQ\ngvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjPl5CC9aIFWM+XkIL1ogVYz5eQgvWiBVjP\nl5CC9aIFWM+XkIL1ogVYz/dLIbVZl0KD9aIFWM/3KyG1hIQfsJ7vF0JquUXCT1jP9/Mhtdy1\nw49Yz/e7If0F8I2Q2pP9LdLf//8W/ID1fD8bUnv94Mt60QKs5/vpkAapl+XerBctwHq+vI4U\nrBctwHq+hBSsFy3Aer6EFKwXLcB6vrzXLlgvWoD1fAkpWC9agPV8CSlYL1qA9XwJKVgvWoD1\nfAkpWC9agPV8CSlYL1qA9XwJKVgvWoD1fAkpWC9agPV8CSlYL1qA9XwJKVgvWoD1fAkpWC9a\ngPV8CSlYL1qA9XwJKVgvWoD1fAkpWC9agPV8CSlYL1qA9XwJKVgvWoD1fAkpWC9agPV8CSlY\nL1qA9XwJKVgvWoD1fAkpWC9agPV8CSlYL1qA9XwJKVgvWoD1fAkpWC9agPV8CSlYL1qA9XwJ\nKVgvWoD1fAkpWC9agPV8CSlYL1qA9XwJCZgBIQEzICRgBoQEzICQgBkQEjADQgJmQEjADAgJ\nmAEhATOoF1L76vNHX8e3tTefPvW9v17BkNrpp3e+vtxFcXUZ8ae+N/WSLIeQ3nx9uYviqh2G\nSEjWhi2PH9t2/Ev/+eYvN1+848X9jSYhTYd4M+b4iofSIV3WPWy0nf7l1RfxFeP03p/w66/c\n72LOipAmn99u2GjTC3onpPHz9MPJarwVQ7pW1LbD/Yv3Q5p+EV8RFf0rJK/x1g4pTvr4lshl\n0wsaR/jvkKa3WQYI6URIc/tMSG73nEuG9M978K6Phhc0jKz935C4a/ebtdP/mzwFGxv2fH52\nQW18em/C1684/TtVLyQgASEBMyAkYAaEBMyAkIAZEBIwA0ICZkBI9/a8bpr1y0df/PLLLM3V\nDy8XvoRx39ehHa716/e//PUcCOk+GPd9tc3j4XTats3zu1/+Xg5EtDxGflcvzcP587ZpL9f/\n88entlk9Dzcv3d8Oj825t/5rD91PHFbNw7H767E//Xg+fd9ObtOGMzo2q8un88+tD6fpz2BW\nhHRXD81u+MP+NA1pc75v9jyGdDzf/WuP/dceuj+9rLoPj6f+5qyzOv/M+nzCaLxF2jTbU9/q\nU3fC43gO8TOYFSHd1c2dsAipaQ6n3fVGatM/glo3m/6vj10Y3Z9e+i889SdtmvMt1+adc92f\nH3n1rXahHYdziJ/BrAjprj4IqXvktI2TVl1Wp0N/M9IH1n04Dl9YDd//MJ7+9lwfmu6Gbuhx\nP55D/AxmRUh39UFI2+4O2OpwOWl6SzU9LZ6ee/XswuWv+y6YbX+fb3oOPKWXgone1fUx0ml3\n82TDab9q2t1PQ+pvy84PlAgpHRO9q8uzdrv2crtxuFzJn6+FTO/anSYfVtflfRTSttm0w3ef\nz2E9/RnMirne1/V1pH3/55fTcT08Rtp198vee7LhNPmw6U966b/4UUhdN+cnHPqP3Tk/TX8G\nsyKk+zqshrta/bNu5ye9n+Lp76e+gPb26e/T5MNw+vkJhY9C2jbNy2l4evx8VpOfwawI6d62\nj+3lvXbd/bCn8Uaobdquo+7+XX/tn74gO/3Qn77enf4R0vh8XvdxPZxD/AxmRUjWdsNrrzy5\nkI4JW1uf39xASPmYsLHru8oJKR0TNtZe3sFASOmYMDADQgJmQEjADAgJmAEhATMgJGAGhATM\ngJCAGfwHeegTMsWINB0AAAAASUVORK5CYII=",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(\n",
    "  model_data,\n",
    "  aes(x = customer_type, y = rating)\n",
    ") +\n",
    "  geom_boxplot() +\n",
    "  labs(\n",
    "    title = \"Customer Rating by Customer Type\",\n",
    "    x = \"Customer Type\",\n",
    "    y = \"Rating\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 54,
   "id": "8fa188c1-71eb-445d-901b-6d0090e01c29",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "\tShapiro-Wilk normality test\n",
       "\n",
       "data:  model_data$quantity\n",
       "W = 0.93258, p-value < 2.2e-16\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "\tShapiro-Wilk normality test\n",
       "\n",
       "data:  model_data$unit_price\n",
       "W = 0.95188, p-value < 2.2e-16\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "\tShapiro-Wilk normality test\n",
       "\n",
       "data:  model_data$rating\n",
       "W = 0.9582, p-value = 2.688e-16\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Normality test for Quantity\n",
    "shapiro.test(model_data$quantity)\n",
    "\n",
    "# Normality test for Unit Price\n",
    "shapiro.test(model_data$unit_price)\n",
    "\n",
    "# Normality test for Rating\n",
    "shapiro.test(model_data$rating)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 55,
   "id": "67ac9db3-5553-44be-abd0-50c0a3a869ef",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'unit_price'</li><li>'quantity'</li><li>'rating'</li><li>'hour'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'unit\\_price'\n",
       "\\item 'quantity'\n",
       "\\item 'rating'\n",
       "\\item 'hour'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'unit_price'\n",
       "2. 'quantity'\n",
       "3. 'rating'\n",
       "4. 'hour'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"unit_price\" \"quantity\"   \"rating\"     \"hour\"      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 4 × 4 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>unit_price</th><th scope=col>quantity</th><th scope=col>rating</th><th scope=col>hour</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>unit_price</th><td> 1.000000000</td><td> 0.010777564</td><td>-0.008777507</td><td> 0.008242210</td></tr>\n",
       "\t<tr><th scope=row>quantity</th><td> 0.010777564</td><td> 1.000000000</td><td>-0.015814905</td><td>-0.007316886</td></tr>\n",
       "\t<tr><th scope=row>rating</th><td>-0.008777507</td><td>-0.015814905</td><td> 1.000000000</td><td>-0.030587644</td></tr>\n",
       "\t<tr><th scope=row>hour</th><td> 0.008242210</td><td>-0.007316886</td><td>-0.030587644</td><td> 1.000000000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 4 × 4 of type dbl\n",
       "\\begin{tabular}{r|llll}\n",
       "  & unit\\_price & quantity & rating & hour\\\\\n",
       "\\hline\n",
       "\tunit\\_price &  1.000000000 &  0.010777564 & -0.008777507 &  0.008242210\\\\\n",
       "\tquantity &  0.010777564 &  1.000000000 & -0.015814905 & -0.007316886\\\\\n",
       "\trating & -0.008777507 & -0.015814905 &  1.000000000 & -0.030587644\\\\\n",
       "\thour &  0.008242210 & -0.007316886 & -0.030587644 &  1.000000000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 4 × 4 of type dbl\n",
       "\n",
       "| <!--/--> | unit_price | quantity | rating | hour |\n",
       "|---|---|---|---|---|\n",
       "| unit_price |  1.000000000 |  0.010777564 | -0.008777507 |  0.008242210 |\n",
       "| quantity |  0.010777564 |  1.000000000 | -0.015814905 | -0.007316886 |\n",
       "| rating | -0.008777507 | -0.015814905 |  1.000000000 | -0.030587644 |\n",
       "| hour |  0.008242210 | -0.007316886 | -0.030587644 |  1.000000000 |\n",
       "\n"
      ],
      "text/plain": [
       "           unit_price   quantity     rating       hour        \n",
       "unit_price  1.000000000  0.010777564 -0.008777507  0.008242210\n",
       "quantity    0.010777564  1.000000000 -0.015814905 -0.007316886\n",
       "rating     -0.008777507 -0.015814905  1.000000000 -0.030587644\n",
       "hour        0.008242210 -0.007316886 -0.030587644  1.000000000"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 9: Correlation Analysis\n",
    "\n",
    "# Select only numeric variables\n",
    "correlation_data <- model_data %>%\n",
    "  select(where(is.numeric))\n",
    "\n",
    "# Check which variables are included\n",
    "names(correlation_data)\n",
    "\n",
    "# Calculate correlation matrix\n",
    "cor_matrix <- cor(\n",
    "  correlation_data,\n",
    "  use = \"complete.obs\"\n",
    ")\n",
    "\n",
    "# Display correlation matrix\n",
    "cor_matrix"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 56,
   "id": "e7f06e58-d24e-4404-8a30-25210058d004",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAACzVBMVEUAAAAFMGEGMmQHNWgJ\nOGwKOnAMPXMNQHcOQnsQRX8RSIITS4YUTYoVUI4XU5EYVZUaWJkbW50cXqEeYKQfY6ghZqwi\naK0kaq4mba8ob7ApcbErc7MtdrQueLUwerYyfLczf7g1gbk3g7s5hbw6iL08ir4+jL8/jsBB\nkcJDk8NHlsRLmMVPm8dRbpFTnchXoMpbostfpcxjp85nAB9nqs9qAR9rhKFrrNBuAiBvr9Jy\nAyBzsdN2BCF3tNR5BiJ7ttZ9ByJ+lK5/udeBCCODu9iFCSOHvtqICiSLwNuMDCWOoriPw92Q\nDSWSxd6UDiaWx9+XDyaZyOCbECecrcCcyuCfEiify+GizeKjEyilz+OnFCmpt8ip0OSqFSms\n0uWuFiqv0+ayGCuy1eezGyy0wc+1Hy611+i3IzC42Om5JjK7KjO82uq9LjW+MTe+vr6+yda/\n2+rANTjCODrC3evEPDzF3+zGQD3HQz/I4O3JR0HLS0PL4u7NTkTPUkbP5O/QVUjR2eLR5fDS\nWUnUXUvU5vHWYE3W6PHXZFDY6fLZZ1Laa1Xb6vPcbljdclrd7PTfdV3f7fTgeGDh5uzifGLi\n7vXjf2Xk7/blg2jmhmrm8ffoim3pjXDp7fHp8vfrkXLr8/jslHXt9fnumHjvm3rv9vrxn33y\nooDy9/r0pYP0qIb0+fv1q4n1rY31sJD2s5T2tpf2+vz3uJv3u574vqL4wKX5w6n5xqz5+/36\nybD6y7P6zrf70br70737/f381sH82cT8/f3928j93cr938394dD94tP95Nb95tn96Nv96t79\n7OH9/v7+7eT+7+f+8en+8+z+9e/+9vL++PX++vf++vj++vn++/n++/r+/Pr+/Pv+/Pz+/fz+\n/f3+/v3+/v7/AAD/TU3/aGj/fHz/jIz/mpr/p6f/srL/vb3/x8f/0ND/2dn/4eH/6en/8PD/\n//8fDqDOAAAACXBIWXMAABJ0AAASdAHeZh94AAAgAElEQVR4nO3dhX8kZ7rd8bfDzMzMDmfD\nsOE4nA1vOA4nvw0zbJjJ4cRhZuZssmFw0PFm7es7KsGwZ/pviKolPepSafS8o6rSqZo638/n\nyqd7WtK5vnNud1WX5LI1s8GKuoDZq8BDMhuBh2Q2Ag/JbAQektkIPCSzEXhIZiPwkMxG4CGZ\n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\nrkJggg==",
      "text/plain": [
       "Plot with title \"\""
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "corrplot(\n",
    "  cor_matrix,\n",
    "  method = \"number\",\n",
    "  type = \"upper\"\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 57,
   "id": "f9457469-7b86-43db-b898-4b32f8db5393",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "\tWelch Two Sample t-test\n",
       "\n",
       "data:  quantity by customer_type\n",
       "t = 1.4867, df = 945.97, p-value = 0.1374\n",
       "alternative hypothesis: true difference in means between group Member and group Normal is not equal to 0\n",
       "95 percent confidence interval:\n",
       " -0.08833615  0.64046717\n",
       "sample estimates:\n",
       "mean in group Member mean in group Normal \n",
       "            5.630088             5.354023 \n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "t_test_quantity <- t.test(\n",
    "  quantity ~ customer_type,\n",
    "  data = model_data\n",
    ")\n",
    "\n",
    "t_test_quantity"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 58,
   "id": "eeb818b5-2e71-4c59-ae1f-bf9fff619721",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "        \n",
       "         Female Male\n",
       "  Member    356  209\n",
       "  Normal    215  220"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "gender_table <- table(\n",
    "  model_data$customer_type,\n",
    "  model_data$gender\n",
    ")\n",
    "\n",
    "gender_table"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 59,
   "id": "0b74eb59-7961-40ef-8cd6-b6d8ff99861a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "\tPearson's Chi-squared test with Yates' continuity correction\n",
       "\n",
       "data:  gender_table\n",
       "X-squared = 17.962, df = 1, p-value = 2.253e-05\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "chi_gender <- chisq.test(gender_table)\n",
    "\n",
    "chi_gender"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 60,
   "id": "bed502a4-280f-4c6f-9bb0-d4c1d73ffa20",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "        \n",
       "         Cash Credit card Ewallet\n",
       "  Member  192         187     186\n",
       "  Normal  152         124     159"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "payment_table <- table(\n",
    "  model_data$customer_type,\n",
    "  model_data$payment\n",
    ")\n",
    "\n",
    "payment_table"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 61,
   "id": "b3394be3-e7bf-44f4-bd78-1fcd72fc2349",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "\tPearson's Chi-squared test\n",
       "\n",
       "data:  payment_table\n",
       "X-squared = 2.6714, df = 2, p-value = 0.263\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "chi_payment <- chisq.test(payment_table)\n",
    "\n",
    "chi_payment"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 62,
   "id": "545aad2c-5721-4f7b-824f-007ea47ab8d7",
   "metadata": {},
   "outputs": [],
   "source": [
    "model_data$customer_type <- as.factor(model_data$customer_type)\n",
    "model_data$gender <- as.factor(model_data$gender)\n",
    "model_data$product_line <- as.factor(model_data$product_line)\n",
    "model_data$payment <- as.factor(model_data$payment)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 63,
   "id": "6d65c36d-7919-4c0e-bea3-171bf3cec04f",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t1000 obs. of  10 variables:\n",
      " $ customer_type: Factor w/ 2 levels \"Member\",\"Normal\": 1 2 2 1 1 1 1 1 1 1 ...\n",
      " $ gender       : Factor w/ 2 levels \"Female\",\"Male\": 1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ product_line : Factor w/ 6 levels \"Electronic accessories\",..: 4 1 5 4 6 1 1 5 4 3 ...\n",
      " $ unit_price   : num  74.7 15.3 46.3 58.2 86.3 ...\n",
      " $ quantity     : int  7 5 7 8 7 7 6 10 2 3 ...\n",
      " $ rating       : num  9.1 9.6 7.4 8.4 5.3 4.1 5.8 8 7.2 5.9 ...\n",
      " $ payment      : Factor w/ 3 levels \"Cash\",\"Credit card\",..: 3 1 2 3 3 3 3 3 2 2 ...\n",
      " $ month        : Ord.factor w/ 12 levels \"Jan\"<\"Feb\"<\"Mar\"<..: 1 3 3 1 2 3 2 2 1 2 ...\n",
      " $ day          : chr  \"Saturday\" \"Friday\" \"Sunday\" \"Sunday\" ...\n",
      " $ hour         : int  13 10 13 20 10 18 14 11 17 13 ...\n"
     ]
    }
   ],
   "source": [
    "str(model_data)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 64,
   "id": "5ab4a479-9401-400e-b24b-572dfd7a0711",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "also installing the dependencies 'TH.data', 'nloptr', 'reformulas', 'RcppEigen', 'plotrix', 'shiny', 'miniUI', 'styler', 'classInt', 'labelled', 'gplots', 'libcoin', 'matrixStats', 'multcomp', 'pkgbuild', 'diffobj', 'Rcpp', 'clock', 'sparsevctrs', 'timeDate', 'brglm', 'gtools', 'lme4', 'qvcalc', 'rex', 'Formula', 'plotmo', 'questionr', 'ROCR', 'mvtnorm', 'modeltools', 'strucchange', 'coin', 'zoo', 'sandwich', 'brio', 'desc', 'pkgload', 'praise', 'waldo', 'ROSE', 'e1071', 'foreach', 'ModelMetrics', 'plyr', 'pROC', 'recipes', 'reshape2', 'BradleyTerry2', 'covr', 'Cubist', 'earth', 'ellipse', 'fastICA', 'gam', 'ipred', 'kernlab', 'klaR', 'mda', 'mlbench', 'MLmetrics', 'pamr', 'party', 'pls', 'randomForest', 'RANN', 'spls', 'superpc', 'testthat', 'themis'\n",
      "\n",
      "\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/TH.data_1.1-5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/nloptr_2.2.1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/RcppEigen_0.3.4.0.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/shiny_1.14.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/miniUI_0.1.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/styler_1.11.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/classInt_0.4-11.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/labelled_2.16.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/gplots_3.3.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/libcoin_1.0-13.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/matrixStats_1.5.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/multcomp_1.4-31.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/pkgbuild_1.4.8.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/diffobj_0.3.8.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/Rcpp_1.1.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/clock_0.7.4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/sparsevctrs_0.3.6.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/timeDate_4052.112.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/brglm_0.7.3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/gtools_3.9.5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/lme4_2.0-6.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/qvcalc_1.0.4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/rex_1.2.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/Formula_1.2-6.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/plotmo_3.7.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/questionr_0.8.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/ROCR_1.0-12.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/mvtnorm_1.4-2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/modeltools_0.2-24.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/strucchange_1.6-0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/coin_1.4-5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/zoo_1.9-0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/sandwich_3.1-3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/brio_1.1.5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/desc_1.4.3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/pkgload_1.5.3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/praise_1.0.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/waldo_0.6.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/ROSE_0.0-4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/e1071_1.7-17.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/foreach_1.5.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/ModelMetrics_1.2.2.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/plyr_1.8.9.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/pROC_1.19.0.1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/recipes_1.3.3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/reshape2_1.4.5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/BradleyTerry2_1.1.3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/covr_3.6.5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/Cubist_0.6.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/earth_5.3.5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/ellipse_0.5.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/fastICA_1.2-7.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/gam_1.22-7.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/ipred_0.9-15.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/kernlab_0.9-33.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/klaR_1.7-4.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/mda_0.5-5.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/mlbench_2.1-10.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/MLmetrics_1.1.3.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/pamr_1.57.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/party_1.3-21.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/pls_2.9-0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/randomForest_4.7-1.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/RANN_2.6.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/spls_2.3-2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/superpc_1.12.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/testthat_3.3.2.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/themis_1.1.0.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"URL 'https://cran.r-project.org/bin/windows/contrib/4.6/caret_7.0-1.zip': Timeout of 60 seconds was reached\"\n",
      "Warning message in download.file(urls, destfiles, \"libcurl\", mode = \"wb\", ...):\n",
      "\"some files were not downloaded\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'TH.data' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'nloptr' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'RcppEigen' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'shiny' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'miniUI' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'styler' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'classInt' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'labelled' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'gplots' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'libcoin' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'matrixStats' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'multcomp' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'pkgbuild' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'diffobj' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'Rcpp' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'clock' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'sparsevctrs' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'timeDate' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'brglm' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'gtools' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'lme4' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'qvcalc' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'rex' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'Formula' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'plotmo' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'questionr' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'ROCR' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'mvtnorm' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'modeltools' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'strucchange' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'coin' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'zoo' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'sandwich' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'brio' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'desc' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'pkgload' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'praise' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'waldo' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'ROSE' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'e1071' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'foreach' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'ModelMetrics' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'plyr' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'pROC' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'recipes' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'reshape2' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'BradleyTerry2' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'covr' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'Cubist' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'earth' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'ellipse' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'fastICA' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'gam' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'ipred' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'kernlab' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'klaR' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'mda' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'mlbench' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'MLmetrics' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'pamr' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'party' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'pls' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'randomForest' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'RANN' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'spls' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'superpc' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'testthat' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'themis' failed\"\n",
      "Warning message in download.packages(pkgs, destdir = tmpd, available = available, :\n",
      "\"download of package 'caret' failed\"\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'reformulas' successfully unpacked and MD5 sums checked\n",
      "package 'plotrix' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\Shreya Srinath\\AppData\\Local\\Temp\\RtmpaWFcAu\\downloaded_packages\n"
     ]
    }
   ],
   "source": [
    "install.packages(\"caret\", dependencies = TRUE)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 65,
   "id": "3c1dc5f0-3c87-4873-9ef6-d25c67324d66",
   "metadata": {},
   "outputs": [
    {
     "ename": "ERROR",
     "evalue": "Error in library(caret): there is no package called 'caret'\n",
     "output_type": "error",
     "traceback": [
      "Error in library(caret): there is no package called 'caret'\nTraceback:\n",
      "1. stop(packageNotFoundError(package, lib.loc, sys.call()))"
     ]
    }
   ],
   "source": [
    "library(caret)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 66,
   "id": "78bc28e3-f1bb-478d-be85-51e1e1df388f",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "800"
      ],
      "text/latex": [
       "800"
      ],
      "text/markdown": [
       "800"
      ],
      "text/plain": [
       "[1] 800"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "200"
      ],
      "text/latex": [
       "200"
      ],
      "text/markdown": [
       "200"
      ],
      "text/plain": [
       "[1] 200"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 14 — Train/Test Split\n",
    "\n",
    "set.seed(123)\n",
    "\n",
    "# Create random training indices\n",
    "train_index <- sample(\n",
    "  1:nrow(model_data),\n",
    "  size = 0.80 * nrow(model_data)\n",
    ")\n",
    "\n",
    "# Create training data\n",
    "train_data <- model_data[train_index, ]\n",
    "\n",
    "# Create testing data\n",
    "test_data <- model_data[-train_index, ]\n",
    "\n",
    "# Check sizes\n",
    "nrow(train_data)\n",
    "nrow(test_data)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 67,
   "id": "444b1f3e-c9f9-424d-b6b9-5b1f97774491",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = customer_type ~ gender + product_line + unit_price + \n",
       "    quantity + rating + payment + month + day + hour, family = binomial, \n",
       "    data = train_data)\n",
       "\n",
       "Coefficients:\n",
       "                                 Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)                      0.194910   0.588276   0.331 0.740400    \n",
       "genderMale                       0.558349   0.149418   3.737 0.000186 ***\n",
       "product_lineFashion accessories  0.043168   0.249062   0.173 0.862399    \n",
       "product_lineFood and beverages  -0.185596   0.247755  -0.749 0.453788    \n",
       "product_lineHealth and beauty   -0.034429   0.262456  -0.131 0.895632    \n",
       "product_lineHome and lifestyle  -0.115349   0.261135  -0.442 0.658691    \n",
       "product_lineSports and travel   -0.113935   0.256704  -0.444 0.657160    \n",
       "unit_price                      -0.004880   0.002787  -1.751 0.079995 .  \n",
       "quantity                        -0.030832   0.025648  -1.202 0.229321    \n",
       "rating                           0.022432   0.043357   0.517 0.604886    \n",
       "paymentCredit card              -0.262909   0.183115  -1.436 0.151071    \n",
       "paymentEwallet                   0.116437   0.175484   0.664 0.506996    \n",
       "month.L                         -0.005246   0.125449  -0.042 0.966642    \n",
       "month.Q                          0.176089   0.129891   1.356 0.175203    \n",
       "dayMonday                        0.235427   0.279232   0.843 0.399159    \n",
       "daySaturday                     -0.009235   0.268073  -0.034 0.972519    \n",
       "daySunday                       -0.133415   0.283963  -0.470 0.638474    \n",
       "dayThursday                      0.089505   0.277847   0.322 0.747350    \n",
       "dayTuesday                      -0.462194   0.276827  -1.670 0.094996 .  \n",
       "dayWednesday                     0.005762   0.277451   0.021 0.983432    \n",
       "hour                            -0.016773   0.023184  -0.723 0.469397    \n",
       "---\n",
       "Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 1098.4  on 799  degrees of freedom\n",
       "Residual deviance: 1061.2  on 779  degrees of freedom\n",
       "AIC: 1103.2\n",
       "\n",
       "Number of Fisher Scoring iterations: 4\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 15 — Logistic Regression Model\n",
    "\n",
    "logistic_model <- glm(\n",
    "  customer_type ~ gender +\n",
    "    product_line +\n",
    "    unit_price +\n",
    "    quantity +\n",
    "    rating +\n",
    "    payment +\n",
    "    month +\n",
    "    day +\n",
    "    hour,\n",
    "  data = train_data,\n",
    "  family = binomial\n",
    ")\n",
    "\n",
    "summary(logistic_model)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 68,
   "id": "274e00e9-a534-4846-b4e2-a7d4080bb7ca",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>1</dt><dd>0.437590050153581</dd><dt>3</dt><dd>0.322446872911142</dd><dt>7</dt><dd>0.444566358166599</dd><dt>9</dt><dd>0.425664269357506</dd><dt>12</dt><dd>0.468402125874792</dd><dt>22</dt><dd>0.333529186907188</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[1] 0.437590050153581\n",
       "\\item[3] 0.322446872911142\n",
       "\\item[7] 0.444566358166599\n",
       "\\item[9] 0.425664269357506\n",
       "\\item[12] 0.468402125874792\n",
       "\\item[22] 0.333529186907188\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "1\n",
       ":   0.4375900501535813\n",
       ":   0.3224468729111427\n",
       ":   0.4445663581665999\n",
       ":   0.42566426935750612\n",
       ":   0.46840212587479222\n",
       ":   0.333529186907188\n",
       "\n"
      ],
      "text/plain": [
       "        1         3         7         9        12        22 \n",
       "0.4375901 0.3224469 0.4445664 0.4256643 0.4684021 0.3335292 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 16 — Generate Predictions\n",
    "\n",
    "predicted_probability <- predict(\n",
    "  logistic_model,\n",
    "  newdata = test_data,\n",
    "  type = \"response\"\n",
    ")\n",
    "\n",
    "head(predicted_probability)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 69,
   "id": "fa376533-01da-43d8-8907-39b90a4f01a5",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>1</dt><dd>Member</dd><dt>3</dt><dd>Member</dd><dt>7</dt><dd>Member</dd><dt>9</dt><dd>Member</dd><dt>12</dt><dd>Member</dd><dt>22</dt><dd>Member</dd></dl>\n",
       "\n",
       "<details>\n",
       "\t<summary style=display:list-item;cursor:pointer>\n",
       "\t\t<strong>Levels</strong>:\n",
       "\t</summary>\n",
       "\t<style>\n",
       "\t.list-inline {list-style: none; margin:0; padding: 0}\n",
       "\t.list-inline>li {display: inline-block}\n",
       "\t.list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "\t</style>\n",
       "\t<ol class=list-inline><li>'Member'</li><li>'Normal'</li></ol>\n",
       "</details>"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[1] Member\n",
       "\\item[3] Member\n",
       "\\item[7] Member\n",
       "\\item[9] Member\n",
       "\\item[12] Member\n",
       "\\item[22] Member\n",
       "\\end{description*}\n",
       "\n",
       "\\emph{Levels}: \\begin{enumerate*}\n",
       "\\item 'Member'\n",
       "\\item 'Normal'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1\n",
       ":   Member3\n",
       ":   Member7\n",
       ":   Member9\n",
       ":   Member12\n",
       ":   Member22\n",
       ":   Member\n",
       "\n",
       "\n",
       "**Levels**: 1. 'Member'\n",
       "2. 'Normal'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "     1      3      7      9     12     22 \n",
       "Member Member Member Member Member Member \n",
       "Levels: Member Normal"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "predicted_class <- ifelse(\n",
    "  predicted_probability >= 0.5,\n",
    "  \"Normal\",\n",
    "  \"Member\"\n",
    ")\n",
    "\n",
    "predicted_class <- factor(\n",
    "  predicted_class,\n",
    "  levels = levels(test_data$customer_type)\n",
    ")\n",
    "\n",
    "head(predicted_class)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 70,
   "id": "9b21b1b4-e112-4023-821b-4238a77d1900",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 10 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Actual</th><th scope=col>Predicted</th><th scope=col>Probability</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Member</td><td>Member</td><td>0.4375901</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Normal</td><td>Member</td><td>0.3224469</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>Member</td><td>Member</td><td>0.4445664</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>Member</td><td>Member</td><td>0.4256643</td></tr>\n",
       "\t<tr><th scope=row>12</th><td>Member</td><td>Member</td><td>0.4684021</td></tr>\n",
       "\t<tr><th scope=row>22</th><td>Member</td><td>Member</td><td>0.3335292</td></tr>\n",
       "\t<tr><th scope=row>25</th><td>Member</td><td>Member</td><td>0.3967074</td></tr>\n",
       "\t<tr><th scope=row>27</th><td>Member</td><td>Member</td><td>0.4498187</td></tr>\n",
       "\t<tr><th scope=row>28</th><td>Member</td><td>Member</td><td>0.3524898</td></tr>\n",
       "\t<tr><th scope=row>32</th><td>Member</td><td>Member</td><td>0.4093133</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 10 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Actual & Predicted & Probability\\\\\n",
       "  & <fct> & <fct> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & Member & Member & 0.4375901\\\\\n",
       "\t3 & Normal & Member & 0.3224469\\\\\n",
       "\t7 & Member & Member & 0.4445664\\\\\n",
       "\t9 & Member & Member & 0.4256643\\\\\n",
       "\t12 & Member & Member & 0.4684021\\\\\n",
       "\t22 & Member & Member & 0.3335292\\\\\n",
       "\t25 & Member & Member & 0.3967074\\\\\n",
       "\t27 & Member & Member & 0.4498187\\\\\n",
       "\t28 & Member & Member & 0.3524898\\\\\n",
       "\t32 & Member & Member & 0.4093133\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 10 × 3\n",
       "\n",
       "| <!--/--> | Actual &lt;fct&gt; | Predicted &lt;fct&gt; | Probability &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | Member | Member | 0.4375901 |\n",
       "| 3 | Normal | Member | 0.3224469 |\n",
       "| 7 | Member | Member | 0.4445664 |\n",
       "| 9 | Member | Member | 0.4256643 |\n",
       "| 12 | Member | Member | 0.4684021 |\n",
       "| 22 | Member | Member | 0.3335292 |\n",
       "| 25 | Member | Member | 0.3967074 |\n",
       "| 27 | Member | Member | 0.4498187 |\n",
       "| 28 | Member | Member | 0.3524898 |\n",
       "| 32 | Member | Member | 0.4093133 |\n",
       "\n"
      ],
      "text/plain": [
       "   Actual Predicted Probability\n",
       "1  Member Member    0.4375901  \n",
       "3  Normal Member    0.3224469  \n",
       "7  Member Member    0.4445664  \n",
       "9  Member Member    0.4256643  \n",
       "12 Member Member    0.4684021  \n",
       "22 Member Member    0.3335292  \n",
       "25 Member Member    0.3967074  \n",
       "27 Member Member    0.4498187  \n",
       "28 Member Member    0.3524898  \n",
       "32 Member Member    0.4093133  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 17 — Prediction Results\n",
    "\n",
    "prediction_results <- data.frame(\n",
    "  Actual = test_data$customer_type,\n",
    "  Predicted = predicted_class,\n",
    "  Probability = predicted_probability\n",
    ")\n",
    "\n",
    "head(prediction_results, 10)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 71,
   "id": "74545464-1efd-4862-9843-d247c6191476",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "        Predicted\n",
       "Actual   Member Normal\n",
       "  Member     90     29\n",
       "  Normal     57     24"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 18 — Confusion Matrix\n",
    "\n",
    "confusion_matrix <- table(\n",
    "  Actual = test_data$customer_type,\n",
    "  Predicted = predicted_class\n",
    ")\n",
    "\n",
    "confusion_matrix"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 72,
   "id": "eb050736-b1b2-49e9-af31-1c4fdcb666b4",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.57"
      ],
      "text/latex": [
       "0.57"
      ],
      "text/markdown": [
       "0.57"
      ],
      "text/plain": [
       "[1] 0.57"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 19 — Accuracy\n",
    "\n",
    "accuracy <- sum(diag(confusion_matrix)) /\n",
    "  sum(confusion_matrix)\n",
    "\n",
    "accuracy"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 73,
   "id": "0e6c23e5-a57c-41ed-b0c9-94a970e17ce0",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "57"
      ],
      "text/latex": [
       "57"
      ],
      "text/markdown": [
       "57"
      ],
      "text/plain": [
       "[1] 57"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "accuracy_percentage <- accuracy * 100\n",
    "\n",
    "accuracy_percentage"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 74,
   "id": "6491f3d0-827d-4da8-8a6f-d94795e2cd79",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.756302521008403"
      ],
      "text/latex": [
       "0.756302521008403"
      ],
      "text/markdown": [
       "0.756302521008403"
      ],
      "text/plain": [
       "[1] 0.7563025"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0.296296296296296"
      ],
      "text/latex": [
       "0.296296296296296"
      ],
      "text/markdown": [
       "0.296296296296296"
      ],
      "text/plain": [
       "[1] 0.2962963"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 20 — Sensitivity and Specificity\n",
    "\n",
    "TP <- confusion_matrix[\"Member\", \"Member\"]\n",
    "FN <- confusion_matrix[\"Member\", \"Normal\"]\n",
    "FP <- confusion_matrix[\"Normal\", \"Member\"]\n",
    "TN <- confusion_matrix[\"Normal\", \"Normal\"]\n",
    "\n",
    "sensitivity <- TP / (TP + FN)\n",
    "\n",
    "specificity <- TN / (TN + FP)\n",
    "\n",
    "sensitivity\n",
    "specificity"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 75,
   "id": "f33a7886-77e9-41c5-b7e9-723e809cd2a9",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "75.6302521008403"
      ],
      "text/latex": [
       "75.6302521008403"
      ],
      "text/markdown": [
       "75.6302521008403"
      ],
      "text/plain": [
       "[1] 75.63025"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "29.6296296296296"
      ],
      "text/latex": [
       "29.6296296296296"
      ],
      "text/markdown": [
       "29.6296296296296"
      ],
      "text/plain": [
       "[1] 29.62963"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sensitivity_percentage <- sensitivity * 100\n",
    "specificity_percentage <- specificity * 100\n",
    "\n",
    "sensitivity_percentage\n",
    "specificity_percentage"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 76,
   "id": "1e24d2cf-9617-4db6-a983-dd3b0cf85a61",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 1 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Accuracy</th><th scope=col>Sensitivity</th><th scope=col>Specificity</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>0.57</td><td>0.7563025</td><td>0.2962963</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 1 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Accuracy & Sensitivity & Specificity\\\\\n",
       " <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 0.57 & 0.7563025 & 0.2962963\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 1 × 3\n",
       "\n",
       "| Accuracy &lt;dbl&gt; | Sensitivity &lt;dbl&gt; | Specificity &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 0.57 | 0.7563025 | 0.2962963 |\n",
       "\n"
      ],
      "text/plain": [
       "  Accuracy Sensitivity Specificity\n",
       "1 0.57     0.7563025   0.2962963  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 21 — Model Performance Summary\n",
    "\n",
    "performance <- data.frame(\n",
    "  Accuracy = accuracy,\n",
    "  Sensitivity = sensitivity,\n",
    "  Specificity = specificity\n",
    ")\n",
    "\n",
    "performance"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 77,
   "id": "b3d3abff-6b64-4c65-868a-9ebf1d1188a3",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAACiFBMVEUAAAAFDRQHDxgHERsJ\nFCAJFSAKFyQLGSYLGigMHCsNHCsNHi4OHy8OHzEOITQPIC4PIjMPIzYQJDcQJDkQJjsRJjoR\nJz0RKD8SKD0TKkATK0MTLEQUKz4ULEMULUUULUYVLUUVLkcVL0gVMEkWMEoWMUoWMUsXMk0X\nM04XNE8YM0oYNE8YNVAYNlEZNlIZN1QaNUsaOFUaOVYaOlcbO1gbO1kcOlMcPFocPVsdPlwd\nP14eQFweQF8eQWAeQmEfQmMfQ2QgRGUgRWYhRWMhRmchR2ghR2kiSGoiSmwjSGUjSmojSm0j\nS24kTHAkTXElTnAlTnIlT3MlT3QmUHUmUXYnUnYnUngnU3koVHsoVXwpVngpVnwpVn0pV34q\nWH8qWYAqWYIrWoErWoMrW4QsXIUsXYYtXYYtXoctX4kuYIouYIsuYYwvYYgvYo0vY44wZI8w\nZZAwZZIxZpMxZ5QyaJUyaZYzapgza5k0a5U0bJs0bZw1bp01b542cKA2caE3cqI3c6M3c6Q4\ndKI4dKY5dqg5d6k5eKo6eas6eaw7eq47e688fK08fLA8fbE9frM9f7Q+gLU+gbc/grg/g7c/\ng7pAhLtAhbxBhr1Bh79CiMBCicFDisBDisJDi8RDjMVEjcdFjshFj8lGkMlGkMtGkcxHks1H\nk89IlNBIldFIltJJltJJl9RJmNVKmddLmthLm9pMnNpMnNtMndxNTU1Nnt1Nn99NoOBOoeFO\nouNPo+RPpOVQpedRpuhRp+lRp+pSqOtSqexTqu5Tq+9UrPBUrfJVrvNVr/RWsPZWsfdoaGh8\nfHyMjIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD///97s81MAAAACXBIWXMA\nABJ0AAASdAHeZh94AAAgAElEQVR4nO3dh59k55nV8Vey7FnbsJLtXdta1rAITJAJIplg0mKS\nlyCSCRLJZIxARLPEBbFEk002UWSTDBcQyeSgSp1V9e9w03PrrVu33r73nao6z5k+389H02Gq\nb9fU/I4qdE132IjIYwvoMyDyJNCQRI5AQxI5Ag1J5Ag0JJEj0JBEjkBDEjkCDUnkCDQkkSPQ\nkESO4AxDulqEEBbX6ROtlyHMDvxeGHEmi8XlXfvq3eWi2Dv6vYdLnQFz/59k5xNNFiI5Hze/\n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\nkYrmxajTjoNOdNfz9TVQ/xoKD53org+Er2tfe0+oHgvXkMz0IRVFffVUVNdS1S/Fpvkl+p1x\n0InuehS+5RPxfabnNaQBz1RXQ5X3h/dULzQkM/4+UrF9Ub9sRtX9Ev3O9sPeSUEnuuODzV2i\nj3Y36N6tIe17v10hfah90MHLkJKhvXPcyQzLH1L7crN7o6/gvEbqHgZ/FB5V10nPv1tD2tc9\nDP6Rp0LzlVkvQ5pQ/IlMeNSuuHdIzW07wiFtv5xkz2x49wsaUl/85aSvb17RkMyUh7+Le4YU\nX2eNgE506/nuCUKljz6qn3r3cT1q1/OB7glC7+0ectCQzBGHNHAfKQmdaKe8Pnph750f09eR\ndpXXR/ZEu7ADeq5ak5o/iUlfkC3uHRLjTbsPDl73PKdnNux4f3e7TkMaMv2ZDfGD3L2bdkXB\nd4308Z2npz7dPbPhaT3XLvKRZ7pbczt8zIhoSKeATrT2wtPhG6M3nwsfbF75aP0cVgfQidY+\n/FTo/1OkhoZkHviQPv700x+L334hhA+W10Tf8lz7ryrw0IlWPvLUUx8a/h0NyTzwIT0X39iv\n3vF8sIe/0WethU608t6Dd4k0JPPAhxT6Q/rEC889HcIjHw80VNCJVg4/tqAhmQc+JP/QiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\nVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLAVWw0JOfQiXLA\n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\nQyfK4fS13keP2jmHTpQDrmKjITmHTpQDrmKzM6TbeQhLPdjgCjpRDudq9rB4SLfNvaNz/KO+\nCjpRDuhEOZwp2YR4SNUzVstfzvU1WXSiHNCJcjhTsgm9n49UfW/I4kyfGp0oB3SiHM6UbMLe\nkM7yT5Fq6EQ5oBPlcKZkEzQk59CJcjhTsgkaknPoRDmcKdkEDck5dKIczpRsgn7QmHPoRDmc\nvtb7aEjOoRPlcPpa76OnCDmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjITmH\nTpQDrmKjITmHTpQDrmKjITmHTpQDrmKjIb35WggvvfblnbfDa28Cz9EOdKK110OnejPE0Oet\nhqvYPPghvdL28MqBt9HQidY+d3hIz6LPWw1XsXnoQ3olfKa68vnKK+Hb67e/GF760tfe/tqX\nXgpvYM+YQSdaezm8PPwbr4bPn/ecHICr2DzwIb0ZXmpfeyV8rXoRwlv1m1/tfgMMnWjtk+HX\nDb7/1fDqmc/JAbiKzb1DKnovD/3+dOhEK68FuzP0lVDdTXqzuyL69vAV0HnahU609uzwDbjP\nP/upM5+RQ7IjPJr7h1TELwZ+P/tToxOthOZ6qH61um33RjesN8MXMWepB51o5fUwPJgXfdxB\n+oKGBBfC9tXq4YXXwlfbN78aXoOcoz50opXPhZc/+8kQnv3U7g28l73csOMYUj2V9teiaN+o\nXu68sfOb4z41OtFKPKTq1Zeit33cSUInWnm5e4zu09F7X3/2Rdg56svu/2imDKnZS3vt1K5m\n+zL+TfNOCjrRymvdPaE36yH1h4WHTrRSXhu9/Hr58nOfjJf06QOPQCAkQ3vnBLvZkzWk9uVm\n6J3jb+qhE618uft60Wc0pIOe7W7Dvbgdz+vBzxUSxzVSt6KiaG6+DQ8p/s1R0InWXgmvVNdJ\nb35GQxrj1e3DDp/2cw+Jbkjbdx2+JiIbkj2T4TNvaUhjbJ/J4OQ5DY1JzZ/Egx/S218up/TK\nl97+Wn0j7zN6sCGte27dq+HboGdk16TmT2LUF2T7jyfY+wcfbBj9qdGJ7vpK/XUkPfx9j25I\nn3Ty5KDG9PCPbcqQto9wb+Lh9B/+Hgud6K436mc2fDH6gqyPJ9uhE61sn+L9+e4RBle37BiG\ndDroRCsvdc9saF7bzmf7HAcsdKKVT3WPK3zWbtB97sCTHUBwFZsHPqQ37IlAX24XZE9afcvJ\nYw0uhvRq+Ob2tW8OrzevfNuh54Nj4Co2D3xI5V6+WF4TffWN8FJz1fRG988ofDzVzsWQvvBi\n+GT19aPPvRg+277n0PPBQXAVmwc+pOoJDe3D3+079A/7hrzYXirdI3XPunqsQUPCe+uNl8rV\nbP+l+dtf1j81H1A/afXT22shJ//E3OAqNg9+SN6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\nSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9hoSM6hE+WAq9ho\n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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 22 — Confusion Matrix Visualization\n",
    "\n",
    "confusion_data <- as.data.frame(confusion_matrix)\n",
    "\n",
    "ggplot(\n",
    "  confusion_data,\n",
    "  aes(\n",
    "    x = Actual,\n",
    "    y = Predicted,\n",
    "    fill = Freq\n",
    "  )\n",
    ") +\n",
    "  geom_tile() +\n",
    "  geom_text(\n",
    "    aes(label = Freq),\n",
    "    size = 6\n",
    "  ) +\n",
    "  labs(\n",
    "    title = \"Confusion Matrix for Customer Type Prediction\",\n",
    "    x = \"Actual Customer Type\",\n",
    "    y = \"Predicted Customer Type\"\n",
    "  ) +\n",
    "  theme_minimal()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 78,
   "id": "2e53c95c-b0bc-4e75-8650-f03e7699e30a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>0.4875</li><li>0.5875</li><li>0.55</li><li>0.6375</li><li>0.6125</li><li>0.6375</li><li>0.55</li><li>0.5875</li><li>0.5625</li><li>0.4625</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 0.4875\n",
       "\\item 0.5875\n",
       "\\item 0.55\n",
       "\\item 0.6375\n",
       "\\item 0.6125\n",
       "\\item 0.6375\n",
       "\\item 0.55\n",
       "\\item 0.5875\n",
       "\\item 0.5625\n",
       "\\item 0.4625\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 0.4875\n",
       "2. 0.5875\n",
       "3. 0.55\n",
       "4. 0.6375\n",
       "5. 0.6125\n",
       "6. 0.6375\n",
       "7. 0.55\n",
       "8. 0.5875\n",
       "9. 0.5625\n",
       "10. 0.4625\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] 0.4875 0.5875 0.5500 0.6375 0.6125 0.6375 0.5500 0.5875 0.5625 0.4625"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 23 — 10-Fold Cross-Validation\n",
    "\n",
    "set.seed(123)\n",
    "\n",
    "k <- 10\n",
    "\n",
    "folds <- sample(\n",
    "  rep(1:k, length.out = nrow(train_data))\n",
    ")\n",
    "\n",
    "cv_accuracy <- numeric(k)\n",
    "\n",
    "for (i in 1:k) {\n",
    "  \n",
    "  cv_train <- train_data[folds != i, ]\n",
    "  cv_test <- train_data[folds == i, ]\n",
    "  \n",
    "  cv_model <- glm(\n",
    "    customer_type ~ gender +\n",
    "      product_line +\n",
    "      unit_price +\n",
    "      quantity +\n",
    "      rating +\n",
    "      payment +\n",
    "      month +\n",
    "      day +\n",
    "      hour,\n",
    "    data = cv_train,\n",
    "    family = binomial\n",
    "  )\n",
    "  \n",
    "  cv_probability <- predict(\n",
    "    cv_model,\n",
    "    newdata = cv_test,\n",
    "    type = \"response\"\n",
    "  )\n",
    "  \n",
    "  cv_prediction <- ifelse(\n",
    "    cv_probability >= 0.5,\n",
    "    \"Normal\",\n",
    "    \"Member\"\n",
    "  )\n",
    "  \n",
    "  cv_accuracy[i] <- mean(\n",
    "    cv_prediction == cv_test$customer_type\n",
    "  )\n",
    "}\n",
    "\n",
    "cv_accuracy"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 79,
   "id": "3d360a7d-f08d-45c0-aaff-652a8491e55f",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.5675"
      ],
      "text/latex": [
       "0.5675"
      ],
      "text/markdown": [
       "0.5675"
      ],
      "text/plain": [
       "[1] 0.5675"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "mean_cv_accuracy <- mean(cv_accuracy)\n",
    "\n",
    "mean_cv_accuracy"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 80,
   "id": "1d17fdc6-974b-4332-83cc-7a418f8e49f5",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "56.75"
      ],
      "text/latex": [
       "56.75"
      ],
      "text/markdown": [
       "56.75"
      ],
      "text/plain": [
       "[1] 56.75"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "mean_cv_accuracy_percentage <- mean_cv_accuracy * 100\n",
    "\n",
    "mean_cv_accuracy_percentage"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 81,
   "id": "94a8ef48-37b1-4299-b856-c2e084b4a939",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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\nIvG1Inohk3qR2K/1waMNcGfDAFReR8oakkqK/ja9A41iQKQBECJS4FFjzhcDIg1A5QVZVpG+\nmTcgUhSINABVDaVYLpubDODRDhBpAE5sqKnob+4lPNqgo0i7TY7OyORkkb6Rl/Bog34iqdWT\n1hxvy5kiffNfwqMNqkTKaU4VfVpZNjf/K6cmI67qVpzDuIYOeJRJjUhZ22yK5KbZ//2n9QH/\n/vfff/8L/tXkE+aRk1drme7fWXh9h4ndNseLVFN2OR3GhSaa6lNzHYmpcaMi8WR9LbqJdM4a\nSZY9cconf3Xhb5YDHiJl0k+kQ6N2A/gTI9Oo2oZi/hYzPEpQF2w4uuwNhE3fWkjuSn1Dcd5Y\njBVSiqoRialFG7a/iD4xIj7JGJHgUYrh7my4sEIedB9lrJEgUopBRLrQJK4CEVE7eJSkTiSe\nFt3P4db6OM6+125+BpFSNAQb2O4sXgF/fKqndpwnO3iUpCX83SHYAH9i1DS0Mv8zFY0BKY0c\nkaDQJjVrJPKPpWh4lEaISHAohQiRmBbGV0XkGgn4iBBJmQcQQ3bUDkwIWiO15ndZBrmOdG9q\no3acJzuIlAYiDYCE60iKKZ5+VSDSAEgQCbGGNNXBBoZWRbdkUnWLEM9xj6ldJrXhb9aIEEhT\n3lCqdsOtomeLINImEGkAihtKrZ60Fq2YZiGXBSINQGlDrS75tRetcB0pjQyRcKpLIkMkLJFS\n1AUbFIdH/gQEfbSNBJEQtUsjIfy9vuMIXeYhQCR4tEPt1I6z7JVIywiF2cQCRJKPRJGW18u1\ndPSeBJHWswbgIUGkcI1kOu3pEDXptufEYpEITEVDpB2q72xgLdvv8A2Rppfqjl/VPHFfIVIm\nVSMS89ku+oEKRZp/zjape41OAkRCZHUHCVG7yCfGoWBAmv1aJFOKz2nZ9No7sxjN+rXSV2/k\nRmSKtHzuKeKJND36Kl3Yp64iuYcji74ctRdku07tNpIrrclINf2nlXLLpssun3qKpNzTI4u+\nHJVRO5YZc00wyl5fWmqhErTWTwwQST4NIvFd7Cvbymqyntld1CeIJJ/a60gcQ1LT9ks8Ysuk\n8P3Gqp5LN5Hsl8exRmplWJGWLLbEudTg1FDvjIBOMtWoTXY4tRdkhYhkciqCrdijkHAdCaSp\nC38rlssK7J2UnN8NPNmDSPKRfB2pNtvLjU4QST4XFMnkfh2baq4TFO6bn26gtpFC5dSO+W/v\n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",
      "text/plain": [
       "Plot with title \"\""
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "\n",
    "# Part 24 — Model Diagnostic Plots\n",
    "\n",
    "par(mfrow = c(2, 2))\n",
    "\n",
    "plot(logistic_model)\n",
    "\n",
    "par(mfrow = c(1, 1))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 82,
   "id": "066e99fc-5316-47b3-ba2d-741ab8cdabcc",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 21 × 4 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Estimate</th><th scope=col>Std. Error</th><th scope=col>z value</th><th scope=col>Pr(&gt;|z|)</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>(Intercept)</th><td> 0.194910080</td><td>0.58827593</td><td> 0.33132425</td><td>0.7403995767</td></tr>\n",
       "\t<tr><th scope=row>genderMale</th><td> 0.558348784</td><td>0.14941825</td><td> 3.73681785</td><td>0.0001863638</td></tr>\n",
       "\t<tr><th scope=row>product_lineFashion accessories</th><td> 0.043167859</td><td>0.24906198</td><td> 0.17332176</td><td>0.8623985244</td></tr>\n",
       "\t<tr><th scope=row>product_lineFood and beverages</th><td>-0.185596392</td><td>0.24775452</td><td>-0.74911406</td><td>0.4537884604</td></tr>\n",
       "\t<tr><th scope=row>product_lineHealth and beauty</th><td>-0.034429162</td><td>0.26245619</td><td>-0.13118060</td><td>0.8956324399</td></tr>\n",
       "\t<tr><th scope=row>product_lineHome and lifestyle</th><td>-0.115348857</td><td>0.26113480</td><td>-0.44172151</td><td>0.6586907425</td></tr>\n",
       "\t<tr><th scope=row>product_lineSports and travel</th><td>-0.113934885</td><td>0.25670399</td><td>-0.44383761</td><td>0.6571599968</td></tr>\n",
       "\t<tr><th scope=row>unit_price</th><td>-0.004880104</td><td>0.00278749</td><td>-1.75071659</td><td>0.0799947398</td></tr>\n",
       "\t<tr><th scope=row>quantity</th><td>-0.030832260</td><td>0.02564847</td><td>-1.20210925</td><td>0.2293212028</td></tr>\n",
       "\t<tr><th scope=row>rating</th><td> 0.022432298</td><td>0.04335686</td><td> 0.51738749</td><td>0.6048856918</td></tr>\n",
       "\t<tr><th scope=row>paymentCredit card</th><td>-0.262909259</td><td>0.18311533</td><td>-1.43575779</td><td>0.1510712747</td></tr>\n",
       "\t<tr><th scope=row>paymentEwallet</th><td> 0.116437312</td><td>0.17548361</td><td> 0.66352243</td><td>0.5069960220</td></tr>\n",
       "\t<tr><th scope=row>month.L</th><td>-0.005246354</td><td>0.12544870</td><td>-0.04182071</td><td>0.9666416264</td></tr>\n",
       "\t<tr><th scope=row>month.Q</th><td> 0.176089297</td><td>0.12989064</td><td> 1.35567350</td><td>0.1752030742</td></tr>\n",
       "\t<tr><th scope=row>dayMonday</th><td> 0.235426922</td><td>0.27923157</td><td> 0.84312431</td><td>0.3991589239</td></tr>\n",
       "\t<tr><th scope=row>daySaturday</th><td>-0.009235041</td><td>0.26807287</td><td>-0.03444974</td><td>0.9725185183</td></tr>\n",
       "\t<tr><th scope=row>daySunday</th><td>-0.133415225</td><td>0.28396301</td><td>-0.46983312</td><td>0.6384742514</td></tr>\n",
       "\t<tr><th scope=row>dayThursday</th><td> 0.089504570</td><td>0.27784706</td><td> 0.32213611</td><td>0.7473495844</td></tr>\n",
       "\t<tr><th scope=row>dayTuesday</th><td>-0.462193831</td><td>0.27682720</td><td>-1.66961132</td><td>0.0949962889</td></tr>\n",
       "\t<tr><th scope=row>dayWednesday</th><td> 0.005761796</td><td>0.27745150</td><td> 0.02076686</td><td>0.9834316340</td></tr>\n",
       "\t<tr><th scope=row>hour</th><td>-0.016772514</td><td>0.02318375</td><td>-0.72345983</td><td>0.4693974221</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 21 × 4 of type dbl\n",
       "\\begin{tabular}{r|llll}\n",
       "  & Estimate & Std. Error & z value & Pr(>\\textbar{}z\\textbar{})\\\\\n",
       "\\hline\n",
       "\t(Intercept) &  0.194910080 & 0.58827593 &  0.33132425 & 0.7403995767\\\\\n",
       "\tgenderMale &  0.558348784 & 0.14941825 &  3.73681785 & 0.0001863638\\\\\n",
       "\tproduct\\_lineFashion accessories &  0.043167859 & 0.24906198 &  0.17332176 & 0.8623985244\\\\\n",
       "\tproduct\\_lineFood and beverages & -0.185596392 & 0.24775452 & -0.74911406 & 0.4537884604\\\\\n",
       "\tproduct\\_lineHealth and beauty & -0.034429162 & 0.26245619 & -0.13118060 & 0.8956324399\\\\\n",
       "\tproduct\\_lineHome and lifestyle & -0.115348857 & 0.26113480 & -0.44172151 & 0.6586907425\\\\\n",
       "\tproduct\\_lineSports and travel & -0.113934885 & 0.25670399 & -0.44383761 & 0.6571599968\\\\\n",
       "\tunit\\_price & -0.004880104 & 0.00278749 & -1.75071659 & 0.0799947398\\\\\n",
       "\tquantity & -0.030832260 & 0.02564847 & -1.20210925 & 0.2293212028\\\\\n",
       "\trating &  0.022432298 & 0.04335686 &  0.51738749 & 0.6048856918\\\\\n",
       "\tpaymentCredit card & -0.262909259 & 0.18311533 & -1.43575779 & 0.1510712747\\\\\n",
       "\tpaymentEwallet &  0.116437312 & 0.17548361 &  0.66352243 & 0.5069960220\\\\\n",
       "\tmonth.L & -0.005246354 & 0.12544870 & -0.04182071 & 0.9666416264\\\\\n",
       "\tmonth.Q &  0.176089297 & 0.12989064 &  1.35567350 & 0.1752030742\\\\\n",
       "\tdayMonday &  0.235426922 & 0.27923157 &  0.84312431 & 0.3991589239\\\\\n",
       "\tdaySaturday & -0.009235041 & 0.26807287 & -0.03444974 & 0.9725185183\\\\\n",
       "\tdaySunday & -0.133415225 & 0.28396301 & -0.46983312 & 0.6384742514\\\\\n",
       "\tdayThursday &  0.089504570 & 0.27784706 &  0.32213611 & 0.7473495844\\\\\n",
       "\tdayTuesday & -0.462193831 & 0.27682720 & -1.66961132 & 0.0949962889\\\\\n",
       "\tdayWednesday &  0.005761796 & 0.27745150 &  0.02076686 & 0.9834316340\\\\\n",
       "\thour & -0.016772514 & 0.02318375 & -0.72345983 & 0.4693974221\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 21 × 4 of type dbl\n",
       "\n",
       "| <!--/--> | Estimate | Std. Error | z value | Pr(&gt;|z|) |\n",
       "|---|---|---|---|---|\n",
       "| (Intercept) |  0.194910080 | 0.58827593 |  0.33132425 | 0.7403995767 |\n",
       "| genderMale |  0.558348784 | 0.14941825 |  3.73681785 | 0.0001863638 |\n",
       "| product_lineFashion accessories |  0.043167859 | 0.24906198 |  0.17332176 | 0.8623985244 |\n",
       "| product_lineFood and beverages | -0.185596392 | 0.24775452 | -0.74911406 | 0.4537884604 |\n",
       "| product_lineHealth and beauty | -0.034429162 | 0.26245619 | -0.13118060 | 0.8956324399 |\n",
       "| product_lineHome and lifestyle | -0.115348857 | 0.26113480 | -0.44172151 | 0.6586907425 |\n",
       "| product_lineSports and travel | -0.113934885 | 0.25670399 | -0.44383761 | 0.6571599968 |\n",
       "| unit_price | -0.004880104 | 0.00278749 | -1.75071659 | 0.0799947398 |\n",
       "| quantity | -0.030832260 | 0.02564847 | -1.20210925 | 0.2293212028 |\n",
       "| rating |  0.022432298 | 0.04335686 |  0.51738749 | 0.6048856918 |\n",
       "| paymentCredit card | -0.262909259 | 0.18311533 | -1.43575779 | 0.1510712747 |\n",
       "| paymentEwallet |  0.116437312 | 0.17548361 |  0.66352243 | 0.5069960220 |\n",
       "| month.L | -0.005246354 | 0.12544870 | -0.04182071 | 0.9666416264 |\n",
       "| month.Q |  0.176089297 | 0.12989064 |  1.35567350 | 0.1752030742 |\n",
       "| dayMonday |  0.235426922 | 0.27923157 |  0.84312431 | 0.3991589239 |\n",
       "| daySaturday | -0.009235041 | 0.26807287 | -0.03444974 | 0.9725185183 |\n",
       "| daySunday | -0.133415225 | 0.28396301 | -0.46983312 | 0.6384742514 |\n",
       "| dayThursday |  0.089504570 | 0.27784706 |  0.32213611 | 0.7473495844 |\n",
       "| dayTuesday | -0.462193831 | 0.27682720 | -1.66961132 | 0.0949962889 |\n",
       "| dayWednesday |  0.005761796 | 0.27745150 |  0.02076686 | 0.9834316340 |\n",
       "| hour | -0.016772514 | 0.02318375 | -0.72345983 | 0.4693974221 |\n",
       "\n"
      ],
      "text/plain": [
       "                                Estimate     Std. Error z value    \n",
       "(Intercept)                      0.194910080 0.58827593  0.33132425\n",
       "genderMale                       0.558348784 0.14941825  3.73681785\n",
       "product_lineFashion accessories  0.043167859 0.24906198  0.17332176\n",
       "product_lineFood and beverages  -0.185596392 0.24775452 -0.74911406\n",
       "product_lineHealth and beauty   -0.034429162 0.26245619 -0.13118060\n",
       "product_lineHome and lifestyle  -0.115348857 0.26113480 -0.44172151\n",
       "product_lineSports and travel   -0.113934885 0.25670399 -0.44383761\n",
       "unit_price                      -0.004880104 0.00278749 -1.75071659\n",
       "quantity                        -0.030832260 0.02564847 -1.20210925\n",
       "rating                           0.022432298 0.04335686  0.51738749\n",
       "paymentCredit card              -0.262909259 0.18311533 -1.43575779\n",
       "paymentEwallet                   0.116437312 0.17548361  0.66352243\n",
       "month.L                         -0.005246354 0.12544870 -0.04182071\n",
       "month.Q                          0.176089297 0.12989064  1.35567350\n",
       "dayMonday                        0.235426922 0.27923157  0.84312431\n",
       "daySaturday                     -0.009235041 0.26807287 -0.03444974\n",
       "daySunday                       -0.133415225 0.28396301 -0.46983312\n",
       "dayThursday                      0.089504570 0.27784706  0.32213611\n",
       "dayTuesday                      -0.462193831 0.27682720 -1.66961132\n",
       "dayWednesday                     0.005761796 0.27745150  0.02076686\n",
       "hour                            -0.016772514 0.02318375 -0.72345983\n",
       "                                Pr(>|z|)    \n",
       "(Intercept)                     0.7403995767\n",
       "genderMale                      0.0001863638\n",
       "product_lineFashion accessories 0.8623985244\n",
       "product_lineFood and beverages  0.4537884604\n",
       "product_lineHealth and beauty   0.8956324399\n",
       "product_lineHome and lifestyle  0.6586907425\n",
       "product_lineSports and travel   0.6571599968\n",
       "unit_price                      0.0799947398\n",
       "quantity                        0.2293212028\n",
       "rating                          0.6048856918\n",
       "paymentCredit card              0.1510712747\n",
       "paymentEwallet                  0.5069960220\n",
       "month.L                         0.9666416264\n",
       "month.Q                         0.1752030742\n",
       "dayMonday                       0.3991589239\n",
       "daySaturday                     0.9725185183\n",
       "daySunday                       0.6384742514\n",
       "dayThursday                     0.7473495844\n",
       "dayTuesday                      0.0949962889\n",
       "dayWednesday                    0.9834316340\n",
       "hour                            0.4693974221"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 25 — Model Coefficients\n",
    "\n",
    "model_coefficients <- summary(logistic_model)$coefficients\n",
    "\n",
    "model_coefficients"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 83,
   "id": "49d7f2ae-c632-45a2-b4d0-81680c93d409",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>(Intercept)</dt><dd>1.21520171008954</dd><dt>genderMale</dt><dd>1.74778414751087</dd><dt>product_lineFashion accessories</dt><dd>1.04411314415463</dd><dt>product_lineFood and beverages</dt><dd>0.830608767409765</dd><dt>product_lineHealth and beauty</dt><dd>0.966156778348306</dd><dt>product_lineHome and lifestyle</dt><dd>0.891055238385555</dd><dt>product_lineSports and travel</dt><dd>0.892316057147465</dd><dt>unit_price</dt><dd>0.995131783936202</dd><dt>quantity</dt><dd>0.96963820653183</dd><dt>rating</dt><dd>1.02268579344578</dd><dt>paymentCredit card</dt><dd>0.768811656593026</dd><dt>paymentEwallet</dt><dd>1.12348707864217</dd><dt>month.L</dt><dd>0.994767384355685</dd><dt>month.Q</dt><dd>1.19254454451645</dd><dt>dayMonday</dt><dd>1.26544890139939</dd><dt>daySaturday</dt><dd>0.990807470763109</dd><dt>daySunday</dt><dd>0.875101652153962</dd><dt>dayThursday</dt><dd>1.09363233080536</dd><dt>dayTuesday</dt><dd>0.629900233913036</dd><dt>dayWednesday</dt><dd>1.00577842743615</dd><dt>hour</dt><dd>0.983367361555342</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[(Intercept)] 1.21520171008954\n",
       "\\item[genderMale] 1.74778414751087\n",
       "\\item[product\\textbackslash{}\\_lineFashion accessories] 1.04411314415463\n",
       "\\item[product\\textbackslash{}\\_lineFood and beverages] 0.830608767409765\n",
       "\\item[product\\textbackslash{}\\_lineHealth and beauty] 0.966156778348306\n",
       "\\item[product\\textbackslash{}\\_lineHome and lifestyle] 0.891055238385555\n",
       "\\item[product\\textbackslash{}\\_lineSports and travel] 0.892316057147465\n",
       "\\item[unit\\textbackslash{}\\_price] 0.995131783936202\n",
       "\\item[quantity] 0.96963820653183\n",
       "\\item[rating] 1.02268579344578\n",
       "\\item[paymentCredit card] 0.768811656593026\n",
       "\\item[paymentEwallet] 1.12348707864217\n",
       "\\item[month.L] 0.994767384355685\n",
       "\\item[month.Q] 1.19254454451645\n",
       "\\item[dayMonday] 1.26544890139939\n",
       "\\item[daySaturday] 0.990807470763109\n",
       "\\item[daySunday] 0.875101652153962\n",
       "\\item[dayThursday] 1.09363233080536\n",
       "\\item[dayTuesday] 0.629900233913036\n",
       "\\item[dayWednesday] 1.00577842743615\n",
       "\\item[hour] 0.983367361555342\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "(Intercept)\n",
       ":   1.21520171008954genderMale\n",
       ":   1.74778414751087product_lineFashion accessories\n",
       ":   1.04411314415463product_lineFood and beverages\n",
       ":   0.830608767409765product_lineHealth and beauty\n",
       ":   0.966156778348306product_lineHome and lifestyle\n",
       ":   0.891055238385555product_lineSports and travel\n",
       ":   0.892316057147465unit_price\n",
       ":   0.995131783936202quantity\n",
       ":   0.96963820653183rating\n",
       ":   1.02268579344578paymentCredit card\n",
       ":   0.768811656593026paymentEwallet\n",
       ":   1.12348707864217month.L\n",
       ":   0.994767384355685month.Q\n",
       ":   1.19254454451645dayMonday\n",
       ":   1.26544890139939daySaturday\n",
       ":   0.990807470763109daySunday\n",
       ":   0.875101652153962dayThursday\n",
       ":   1.09363233080536dayTuesday\n",
       ":   0.629900233913036dayWednesday\n",
       ":   1.00577842743615hour\n",
       ":   0.983367361555342\n",
       "\n"
      ],
      "text/plain": [
       "                    (Intercept)                      genderMale \n",
       "                      1.2152017                       1.7477841 \n",
       "product_lineFashion accessories  product_lineFood and beverages \n",
       "                      1.0441131                       0.8306088 \n",
       "  product_lineHealth and beauty  product_lineHome and lifestyle \n",
       "                      0.9661568                       0.8910552 \n",
       "  product_lineSports and travel                      unit_price \n",
       "                      0.8923161                       0.9951318 \n",
       "                       quantity                          rating \n",
       "                      0.9696382                       1.0226858 \n",
       "             paymentCredit card                  paymentEwallet \n",
       "                      0.7688117                       1.1234871 \n",
       "                        month.L                         month.Q \n",
       "                      0.9947674                       1.1925445 \n",
       "                      dayMonday                     daySaturday \n",
       "                      1.2654489                       0.9908075 \n",
       "                      daySunday                     dayThursday \n",
       "                      0.8751017                       1.0936323 \n",
       "                     dayTuesday                    dayWednesday \n",
       "                      0.6299002                       1.0057784 \n",
       "                           hour \n",
       "                      0.9833674 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Odds Ratios\n",
    "\n",
    "odds_ratios <- exp(coef(logistic_model))\n",
    "\n",
    "odds_ratios"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 84,
   "id": "ff34c575-5d82-4dc7-85de-946aa9196567",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = customer_type ~ gender + product_line + quantity + \n",
       "    payment + rating, family = binomial, data = train_data)\n",
       "\n",
       "Coefficients:\n",
       "                                 Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept)                     -0.341169   0.399728  -0.854 0.393381    \n",
       "genderMale                       0.557039   0.146765   3.795 0.000147 ***\n",
       "product_lineFashion accessories  0.001173   0.244044   0.005 0.996164    \n",
       "product_lineFood and beverages  -0.223640   0.243319  -0.919 0.358031    \n",
       "product_lineHealth and beauty   -0.057194   0.257104  -0.222 0.823960    \n",
       "product_lineHome and lifestyle  -0.109423   0.255059  -0.429 0.667914    \n",
       "product_lineSports and travel   -0.139653   0.251419  -0.555 0.578582    \n",
       "quantity                        -0.031062   0.025306  -1.227 0.219658    \n",
       "paymentCredit card              -0.248527   0.180769  -1.375 0.169184    \n",
       "paymentEwallet                   0.120662   0.173240   0.697 0.486114    \n",
       "rating                           0.021845   0.042784   0.511 0.609633    \n",
       "---\n",
       "Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 1098.4  on 799  degrees of freedom\n",
       "Residual deviance: 1073.9  on 789  degrees of freedom\n",
       "AIC: 1095.9\n",
       "\n",
       "Number of Fisher Scoring iterations: 4\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 26 — Improved Logistic Regression Model\n",
    "\n",
    "improved_model <- glm(\n",
    "  customer_type ~ gender +\n",
    "    product_line +\n",
    "    quantity +\n",
    "    payment +\n",
    "    rating,\n",
    "  data = train_data,\n",
    "  family = binomial\n",
    ")\n",
    "\n",
    "summary(improved_model)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 85,
   "id": "c19ea572-e75d-4c03-9e97-dedaed761316",
   "metadata": {},
   "outputs": [],
   "source": [
    "# Part 27 — Improved Model Predictions\n",
    "\n",
    "improved_probability <- predict(\n",
    "  improved_model,\n",
    "  newdata = test_data,\n",
    "  type = \"response\"\n",
    ")\n",
    "\n",
    "improved_class <- ifelse(\n",
    "  improved_probability >= 0.5,\n",
    "  \"Normal\",\n",
    "  \"Member\"\n",
    ")\n",
    "\n",
    "improved_class <- factor(\n",
    "  improved_class,\n",
    "  levels = levels(test_data$customer_type)\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 86,
   "id": "e2a90575-4c7b-416f-9147-e87c15e50a19",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "        Predicted\n",
       "Actual   Member Normal\n",
       "  Member     92     27\n",
       "  Normal     57     24"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 28 — Improved Model Confusion Matrix\n",
    "\n",
    "improved_confusion <- table(\n",
    "  Actual = test_data$customer_type,\n",
    "  Predicted = improved_class\n",
    ")\n",
    "\n",
    "improved_confusion"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 87,
   "id": "8eb68055-a68e-41d1-910e-aa67336416d6",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.58"
      ],
      "text/latex": [
       "0.58"
      ],
      "text/markdown": [
       "0.58"
      ],
      "text/plain": [
       "[1] 0.58"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "improved_accuracy <- sum(\n",
    "  diag(improved_confusion)\n",
    ") / sum(improved_confusion)\n",
    "\n",
    "improved_accuracy"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 88,
   "id": "8892cf32-a93a-40d7-be60-44b7d7d8be19",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "58"
      ],
      "text/latex": [
       "58"
      ],
      "text/markdown": [
       "58"
      ],
      "text/plain": [
       "[1] 58"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "improved_accuracy_percentage <- improved_accuracy * 100\n",
    "\n",
    "improved_accuracy_percentage"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 89,
   "id": "645c1fb7-98b1-493c-a8d4-82f7a4d0bbf1",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Model</th><th scope=col>Accuracy</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Full Logistic Regression    </td><td>0.57</td></tr>\n",
       "\t<tr><td>Improved Logistic Regression</td><td>0.58</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " Model & Accuracy\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Full Logistic Regression     & 0.57\\\\\n",
       "\t Improved Logistic Regression & 0.58\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 2\n",
       "\n",
       "| Model &lt;chr&gt; | Accuracy &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| Full Logistic Regression     | 0.57 |\n",
       "| Improved Logistic Regression | 0.58 |\n",
       "\n"
      ],
      "text/plain": [
       "  Model                        Accuracy\n",
       "1 Full Logistic Regression     0.57    \n",
       "2 Improved Logistic Regression 0.58    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 29 — Model Comparison\n",
    "\n",
    "model_comparison <- data.frame(\n",
    "  Model = c(\n",
    "    \"Full Logistic Regression\",\n",
    "    \"Improved Logistic Regression\"\n",
    "  ),\n",
    "  \n",
    "  Accuracy = c(\n",
    "    accuracy,\n",
    "    improved_accuracy\n",
    "  )\n",
    ")\n",
    "\n",
    "model_comparison"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 90,
   "id": "8153e894-ad8e-41aa-a21a-5018b80443cf",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Model</th><th scope=col>Accuracy</th><th scope=col>Accuracy_Percentage</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Full Logistic Regression    </td><td>0.57</td><td>57</td></tr>\n",
       "\t<tr><td>Improved Logistic Regression</td><td>0.58</td><td>58</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Model & Accuracy & Accuracy\\_Percentage\\\\\n",
       " <chr> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Full Logistic Regression     & 0.57 & 57\\\\\n",
       "\t Improved Logistic Regression & 0.58 & 58\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 3\n",
       "\n",
       "| Model &lt;chr&gt; | Accuracy &lt;dbl&gt; | Accuracy_Percentage &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| Full Logistic Regression     | 0.57 | 57 |\n",
       "| Improved Logistic Regression | 0.58 | 58 |\n",
       "\n"
      ],
      "text/plain": [
       "  Model                        Accuracy Accuracy_Percentage\n",
       "1 Full Logistic Regression     0.57     57                 \n",
       "2 Improved Logistic Regression 0.58     58                 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "model_comparison$Accuracy_Percentage <-\n",
    "  model_comparison$Accuracy * 100\n",
    "\n",
    "model_comparison"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 91,
   "id": "77519479-02ee-4600-98b7-5706e3f335f3",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 15 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Actual</th><th scope=col>Predicted</th><th scope=col>Probability</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Member</td><td>Member</td><td>0.4375901</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Normal</td><td>Member</td><td>0.3224469</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>Member</td><td>Member</td><td>0.4445664</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>Member</td><td>Member</td><td>0.4256643</td></tr>\n",
       "\t<tr><th scope=row>12</th><td>Member</td><td>Member</td><td>0.4684021</td></tr>\n",
       "\t<tr><th scope=row>22</th><td>Member</td><td>Member</td><td>0.3335292</td></tr>\n",
       "\t<tr><th scope=row>25</th><td>Member</td><td>Member</td><td>0.3967074</td></tr>\n",
       "\t<tr><th scope=row>27</th><td>Member</td><td>Member</td><td>0.4498187</td></tr>\n",
       "\t<tr><th scope=row>28</th><td>Member</td><td>Member</td><td>0.3524898</td></tr>\n",
       "\t<tr><th scope=row>32</th><td>Member</td><td>Member</td><td>0.4093133</td></tr>\n",
       "\t<tr><th scope=row>35</th><td>Member</td><td>Member</td><td>0.3497234</td></tr>\n",
       "\t<tr><th scope=row>43</th><td>Member</td><td>Member</td><td>0.3368130</td></tr>\n",
       "\t<tr><th scope=row>47</th><td>Member</td><td>Member</td><td>0.2908442</td></tr>\n",
       "\t<tr><th scope=row>60</th><td>Member</td><td>Member</td><td>0.3406702</td></tr>\n",
       "\t<tr><th scope=row>66</th><td>Member</td><td>Member</td><td>0.4281014</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 15 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Actual & Predicted & Probability\\\\\n",
       "  & <fct> & <fct> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & Member & Member & 0.4375901\\\\\n",
       "\t3 & Normal & Member & 0.3224469\\\\\n",
       "\t7 & Member & Member & 0.4445664\\\\\n",
       "\t9 & Member & Member & 0.4256643\\\\\n",
       "\t12 & Member & Member & 0.4684021\\\\\n",
       "\t22 & Member & Member & 0.3335292\\\\\n",
       "\t25 & Member & Member & 0.3967074\\\\\n",
       "\t27 & Member & Member & 0.4498187\\\\\n",
       "\t28 & Member & Member & 0.3524898\\\\\n",
       "\t32 & Member & Member & 0.4093133\\\\\n",
       "\t35 & Member & Member & 0.3497234\\\\\n",
       "\t43 & Member & Member & 0.3368130\\\\\n",
       "\t47 & Member & Member & 0.2908442\\\\\n",
       "\t60 & Member & Member & 0.3406702\\\\\n",
       "\t66 & Member & Member & 0.4281014\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 15 × 3\n",
       "\n",
       "| <!--/--> | Actual &lt;fct&gt; | Predicted &lt;fct&gt; | Probability &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | Member | Member | 0.4375901 |\n",
       "| 3 | Normal | Member | 0.3224469 |\n",
       "| 7 | Member | Member | 0.4445664 |\n",
       "| 9 | Member | Member | 0.4256643 |\n",
       "| 12 | Member | Member | 0.4684021 |\n",
       "| 22 | Member | Member | 0.3335292 |\n",
       "| 25 | Member | Member | 0.3967074 |\n",
       "| 27 | Member | Member | 0.4498187 |\n",
       "| 28 | Member | Member | 0.3524898 |\n",
       "| 32 | Member | Member | 0.4093133 |\n",
       "| 35 | Member | Member | 0.3497234 |\n",
       "| 43 | Member | Member | 0.3368130 |\n",
       "| 47 | Member | Member | 0.2908442 |\n",
       "| 60 | Member | Member | 0.3406702 |\n",
       "| 66 | Member | Member | 0.4281014 |\n",
       "\n"
      ],
      "text/plain": [
       "   Actual Predicted Probability\n",
       "1  Member Member    0.4375901  \n",
       "3  Normal Member    0.3224469  \n",
       "7  Member Member    0.4445664  \n",
       "9  Member Member    0.4256643  \n",
       "12 Member Member    0.4684021  \n",
       "22 Member Member    0.3335292  \n",
       "25 Member Member    0.3967074  \n",
       "27 Member Member    0.4498187  \n",
       "28 Member Member    0.3524898  \n",
       "32 Member Member    0.4093133  \n",
       "35 Member Member    0.3497234  \n",
       "43 Member Member    0.3368130  \n",
       "47 Member Member    0.2908442  \n",
       "60 Member Member    0.3406702  \n",
       "66 Member Member    0.4281014  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Part 30 — Final Prediction Results\n",
    "\n",
    "final_results <- data.frame(\n",
    "  Actual = test_data$customer_type,\n",
    "  Predicted = predicted_class,\n",
    "  Probability = predicted_probability\n",
    ")\n",
    "\n",
    "head(final_results, 15)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 92,
   "id": "f97165b7-c3d8-4d48-8f67-c5f38ee9755b",
   "metadata": {},
   "outputs": [],
   "source": [
    "write.csv(\n",
    "  final_results,\n",
    "  \"Week_3_Classification_Results.csv\",\n",
    "  row.names = FALSE\n",
    ")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "5e7c3ff6-bbd2-435d-9553-7685a9621327",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.6.1"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
