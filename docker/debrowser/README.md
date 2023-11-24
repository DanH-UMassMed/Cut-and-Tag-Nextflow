# Sofware Provided

| Docker Tag | DEBrowser   | DESeq2  |
|------------|-------------|---------|
| 1.0.1      | v1.26.0     | v1.38.0 |

## DEBrowser
---

[https://github.com/UMMS-Biocore/debrowser](https://github.com/UMMS-Biocore/debrowser)

DEBrowser utilizes Shiny, a R based application development tool that creates a wonderful interactive user interface (UI) combined with all of the computing prowess of R. After the user has selected the data to analyze and has used the shiny UI to run DE analysis, the results are then input to DEBrowser. DEBrowser manipulates your results in a way that allows for interactive plotting by which changing padj or fold change limits also changes the displayed graph(s). For more details about these plots and tables, please visit our quick start guide for some helpful tutorials.

# Usage

To run DEBrowser .

Note: the initial load time can be slow taking upto apoximately 30 seconds on some systems.

<br>


```
docker run --platform linux/amd64 -p 8088:8088 -t danhumassmed/debrowser:1.0.1 Rscript /startDEBrowser.R
```

<br>

