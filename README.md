# Women_Empowerment_Fertility
Women’s Empowerment Indicators as Correlates of High-Risk Fertility Behaviors among Married Adolescent Girls in Northern Nigeria.

First, execute [`Women's empowerment and Fertility_2023NDHS.do`](Women's empowerment and Fertility_2023NDHS.do) to save a clean 2023 Nigeria data obtained from [2023 Nigeria Demographic and Health Survey ](https://dhsprogram.com/data/dataset/Nigeria_Standard-DHS_2018.cfm?flag=1) 
 
Secondly, execute [`Women's empowerment and Fertility_IPUMS.do`](Women's empowerment and Fertility_IPUMS.do) to save a clean 2008-2018 data obtained from [IPUMS 2008-2018 Nigeria Demographic and Health Survey ](https://www.idhsdata.org/idhs-action/samples). This second step appends the 2023 NDHS data, fits the multivariate probit regressions, and generates the marginal effects. The marginal effects are manually extracted and plotted in the third and last step.

Execute [`Graphs of probits.do`](Graphs of probits.do) to plot the graphs of marginal effects and export them.
