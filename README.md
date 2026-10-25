# Climate Exposure & Mispricing Score for hard-to-abate sectors

Semester project for *Research and Emerging Topics in Data Science: Climate Risks* (AIDAMS, CentraleSupélec / ESSEC).
Team: Louis, Oscar, Lucas and Adrien. Role: Climate Risk Analyst (Finance / Quant).

## Research question

> Does the market correctly price transition risk across sectors, and can we build a quantitative mispricing score,
> with uncertainty estimated by Monte Carlo simulation, to measure it?

Sectors: aviation, automotive, cement and materials, maritime shipping.

## Design

1. **Stage 1, exposure.** Simulate how much carbon regulation costs each company relative to its EBITDA
   (EU ETS, CBAM, EU fleet CO2 rules, FuelEU Maritime), by scenario, with Monte Carlo uncertainty.
2. **Stage 2, mispricing.** Regress observed EV/EBITDA on the Stage 1 exposure with controls
   (leverage, growth, sector, region). The residual is the mispricing score; we rank companies on it
   for a theoretical long/short. Raw multiple gaps are not used as mispricing, because they mix in other drivers.

Investment theses are research hypotheses, not recommendations.

## What is in this repository

| Path | Content |
|---|---|
| `labs/lab5.ipynb` | Lab 5, "Put Uncertainty Into Your Project": the sector-level input of Stage 1 (gross EU ETS carbon cost of aviation + cement, EUR bn per year) with back-test, Monte Carlo range for 2030, scenarios and a fan chart. |
| `labs/fig_uncertainty.png` | Fan chart produced by the notebook (history, then 50% and 90% bands per scenario for 2030). |
| `labs/data/eu-ets-sector-emissions.csv` | EU ETS verified emissions by sector (EEA, from the EU Transaction Log). |
| `labs/data/icap-graph-price-data-2005-01-01-2026-10-25.csv` | EU ETS allowance prices (ICAP Allowance Price Explorer, primary market). |
| `labs/data/company_inputs.csv` | Placeholder for company-level inputs (`company, sector, emissions_mt, paid_share, ebitda_eur_bn`). Empty for now: the company bridge in the notebook is skipped until it is filled. |
| `requirements.txt`, `setup_venv.sh` | Python environment. |

## How to run

```bash
bash setup_venv.sh
source .venv/bin/activate
jupyter lab labs/lab5.ipynb      # kernel: Python (lab5), then Kernel -> Restart & Run All
```

The notebook reads its data from `labs/data/` with relative paths, so it must be run from the notebook's own folder
(JupyterLab does this by default).

## Main results of Lab 5 (2030, gross cost, before free allocation)

* Baseline: median EUR 9.5 bn, 90% interval EUR 2.6 to 37.0 bn.
* The carbon price drives the range: fixing it cuts the relative half-width from 180% to 8%.
* The largest gap between scenario medians (EUR 13.6 bn, 50 vs 150 EUR/t) is smaller than the width of any single scenario.
* Back-test on 2021-2025 (trained on 2013-2020): the linear model holds in 0 of 5 years, the log-linear model in 5 of 5 (with very wide bands),
  and a model that forecasts emissions and price separately in 4 of 5, with bands 42% narrower.

## Known limitations and open checks

* "Gross" cost values every tonne at the market price. Free allocation is only bounded by a cement scenario
  (CBAM schedule); installation-level data would replace it.
* Prices come from 7 annual changes since 2018 for the volatility estimate. The EUA futures curve (December 2030)
  and option-implied volatility would be better inputs.
* To verify at the source: whether the 2025 emissions are final, and the 2012 aviation point
  (probably a scope change, so the series starts in 2013).
* 2030 emission paths are judgement calls, documented in the notebook.

## Data policy

Raw Bloomberg exports are licensed data and must not be committed. Only derived, aggregated inputs go in `labs/data/`.
