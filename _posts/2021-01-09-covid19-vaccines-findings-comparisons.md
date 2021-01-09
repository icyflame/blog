---
layout: post
comments: true
title: Comparison of metrics of COVID-19 vaccines
categories: covid19 vaccines science research
---

Over the past few days, several countries have approved vaccine candidates for emergency use and
even wider use. In the US and in India, 2 vaccines have been approved. In the UK, both vaccines that
were approved in the US have been approved, along with one that has been approved in India (under a
different brand name). After seeing all these approvals, I wanted to understand what their
comparative merits and demerits were. In particular, I wanted to understand the size of their
clinical trials, the confidence each had in their efficacy numbers and their safety profiles. To
this end, I read the "Primary results" research papers for all 4 vaccines. This post will try to
compare the headline numbers, and explain some of the similarities between the trials, and the
things that seem to have happened only with a single vaccine.

**Side note:** These papers were clearly written with very little medical terminology. I was able to
understand them once I knew what terms like [Seroconversion](https://en.wikipedia.org/wiki/Seroconversion) and [Immunogenicity](https://en.wikipedia.org/wiki/Immunogenicity) meant. The papers do
have a considerable amount of graphs and numbers, so parsing them is an important part of reading
them.

<!--more-->

Here's a quick comparison table of the efficacy numbers, along with their 95% confidence intervals.

| Vaccine                                 | Approved countries                                                                                                                                                                                                              | Trial size                                                                                                                             | Efficacy | Confidence intervals |
|-----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|----------|----------------------|
| Oxford-AstraZeneca^# (2 standard doses) | [UK](https://www.cbsnews.com/news/covid-vaccine-oxford-astrazeneca-approved-uk-emergency-use/), [India](https://time.com/5926004/india-authorizes-covid-19-vaccines/) (as Covishield)                                           | 8800, 1:1 vaccine:placebo                                                                                                              | 62.1%    | 34.7 (41, 75.7)      |
| Pfizer                                  | [US](https://www.nytimes.com/2020/12/11/health/pfizer-vaccine-authorized.html), [UK](https://www.nytimes.com/2020/12/02/world/europe/pfizer-coronavirus-vaccine-approved-uk.html)                                               | [42,000](https://clinicaltrials.gov/ct2/show/NCT04368728?term=pfizer&cond=Covid19&cntry=US&draw=2&rank=2), 1:1 vaccine:placebo         | 95%      | 7.3 (90.3, 97.6)     |
| Moderna                                 | [US](https://www.nytimes.com/2020/12/19/world/the-fda-approves-modernas-covid-vaccine-adding-millions-more-doses-to-the-us-supply.html), [UK](https://www.cnbc.com/2021/01/08/uk-regulator-approves-moderna-covid-vaccine.html) | [30,400](https://clinicaltrials.gov/ct2/show/NCT04470427?term=moderna&cond=Covid19&cntry=US&draw=2&rank=2), 1:1 vaccine:placebo        | 94%      | 7.5 (89.3, 96.8)     |
| Bharat Biotech (Covaxin)                | [India](https://time.com/5926004/india-authorizes-covid-19-vaccines/)                                                                                                                                                           | Phase 2: [380](https://clinicaltrials.gov/ct2/show/NCT04471519?term=bharat+biotech&cond=Covid19&draw=2&rank=1) (1:1 vaccine1:vaccine2) | UNKNOWN  | NA                   |

**#**: Only Interim results of the phase 3 clinical trial have been published. For the AstraZeneca
vaccine, I am reporting the 2 Standard Doses efficacy. This trial had some peculiar mixing of a
half-dose and a standard dose variant which had an efficiency of 70.4% (54.8, 80.6), but this is not
the variant that will be inoculated to people. In fact, this (half-dose, standard dose) variant
seems to have come out of an inaccurate measuring methodology, and was not a planned variant. More
on this later.

From just these numbers, it is abundantly clear that the Pfizer and Moderna vaccines are way ahead
of the rest of the vaccines in this pack. The timing of the approvals in India is also worth noting:
Both the approvals came days after the approval in the UK.

Another astonishing fact is that the Bharat Biotech vaccine which has been approved by the regulator
in India does not have a valid efficacy number yet because their Phase 3 clinical trial is [still
ongoing](https://clinicaltrials.gov/ct2/show/NCT04641481), and not <span class="underline">even</span> the Interim results from those trials have been released. The regulator has
[claimed](https://www.ndtv.com/india-news/oxford-covid-19-vaccine-bharat-biotechs-covaxin-get-final-approval-by-drug-regulator-will-be-indias-first-vaccines-2347053) that it is a safe vaccine, even though the largest trial for that vaccine has been the phase
2 trial which had 380 participants.


# Astra-Zeneca's Clinical Trial

As I was reading the paper with the interim results for the AstraZeneca, I noticed that it was
markedly different from the other papers in some major aspects.


## Inaccurate measurement leads to the creation of 2 sub-groups

In the trial COV0002 that was held in UK, there seems to have been some lapse between the
manufacturing of the vaccine and it's quality check. Here's the relevant part of the paper:

> Initial dosing in COV002 was with a batch manufactured at a contract manufacturing organisation
> using chromatographic purification. During quality control of this second batch, differences were
> observed between the quantification methods (spectrophotometry and quantitative PCR [qPCR])
> prioritised by different manufacturing sites. In consultation with the national regulator (Medicines
> and Healthcare products Regulatory Agency), we selected a dose of 5 × 1010 viral particles by
> spectrophotometer (2·2 × 1010 viral particles by qPCR), in order to be consistent with the use of
> spectrophotometry in the phase 1 study (COV001), 5 and to ensure the dose was within a safe and
> immunogenic range according to measurements by both methods. A lower-than-anticipated reactogenicity
> profile was noted in the trial, and unexpected interference of an excipient with the
> spectrophotometry assay was identified. After review and approval by the regulator, it was concluded
> that the qPCR (low-dose) reading was more accurate and further doses were adjusted to the standard
> dose (5 × 1010 viral particles) using a qPCR assay. The protocol was amended on June 5, 2020,
> resulting in enrolment of two distinct groups with different dosing regimens with no pause in
> enrollment

This inadvertent creation of a new sub-group in the test, with an already small size of 3744 people
lead to the reduction of the people who got the "2 Standard Doses" regiment to 2377. The remaining
1367 people were the ones who were included in the "Lower Dose/Standard Dose (LD/SD)" regiment and
the only thing that was required to become a part of the group was that you would have had to arrive
at the trial site between 31st May 2020 and 10th Jun 2020. The careful composition of the original
trial group was affected due to this sub-group, and the observed higher efficacy within this group
(90% in LD/SD against 60.3% in SD/SD) could be a consequence of this lack of proper composition of
the subgroup. The authors say that although this number isn't conclusive by itself, it's presence
indicates that conducting a new trial with a smaller primer dose (the first dose) will be useful.


## Pooling of data across 3 countries

AstraZeneca's phase 3 Interim results are actually the results of 4 trials that are being conducted
simultaneously. Of the 4 trials, 2 are happening in the UK, 1 in Brazil and 1 in South Africa. The
size of each of the trials is small and ranges from 1077 (COV1 in UK) to 3744 (COV2 in UK). Of these
4, only 2 had enough cases to reach the Interim results announcement stage.


## Wide confidence intervals

This is perhaps one thing that one should take note of. The lower bound of the confidence interval
for efficacy is 41%. While there's no telling what the actual efficacy is, this wide confidence
interval raises some questions about the size of the trial, and whether the size should have been
bigger to ensure that the interval was smaller.

The author's also note this about the 90% efficacy that is seen in the LD/SD subgroup. The CIs for
this value is 67.4% to 97%, a width of about 29.6%.

> Use of a low dose for priming could provide substantially more vaccine for distribution at a time of
> constrained supply, and these data imply that this would not compromise protection. While a vaccine
> that could prevent COVID-19 would have a substantial public health benefit, prevention of
> asymptomatic infection could reduce viral transmission and protect those with underlying health
> conditions who do not respond to vaccination, those who cannot be vaccinated for health reasons, and
> those who will not or cannot access a vaccine, providing wider benefit for society. However, the
> wide CIs around our estimates show that further data are needed to confirm these preliminary
> findings, which will be done in future analyses of the data accruing in these ongoing trials.


# Vaccine safety

The safety of each vaccine was also a major endpoint in all these studies and they had several
categories of adverse events. Directly related to the vaccine, the adverse events were categorized
as "Local" and "Systemic", and these were solicited for 7 days after the first and second
injection. The thing to look for here is a higher incidence of local and systemic adverse events in
the participants who are in the Vaccine group.

Apart from this, throughout the study, the trial participants were supposed to report adverse events
and severe adverse events to the trial conductor. Here, the thing to look for is similar incidence
of serious adverse events in both the vaccine and the control groups. (These included things like
death by homicide in the AstraZeneca trial or death by suicide or cardiac arrest in the Moderna
trial; they are used to record the adverse events that happen during the trial but are not related
to the vaccine or the trial's characteristics)

I noticed that 2 things happened in all three phase 3 trials:

1.  Younger participants (16-55) were more prone to local and systemic adverse events than older
    adults (>=55). The most common adverse event was pain at the injection site after the first and
    second dose, and these numbers hovered around 5-10% of all the participants. Fortunately, the
    resolution time for these adverse events was within 3-4 days in all trials
2.  The vaccines didn't lead to "enhanced respiratory disease after infection" (Moderna). This was a
    concern that was voiced by several scientists and journalists who are familiar with this issue
    when the vaccine development was starting. The Moderna paper explained this well:

    > The mRNA-1273 vaccine did not show evi- dence in the short term of enhanced respiratory disease
    > after infection, a concern that emerged from animal models used in evaluating some SARS and Middle
    > East respiratory syndrome (MERS) vaccine constructs. 23-25 A hallmark of enhanced respiratory
    > disease is a Th2-skewed 12 immune response and eosinophilic pulmonary infiltration on
    > histopathological examination.  Of note, preclinical testing of mRNA-1273 and other SARS-CoV-2
    > vaccines in advanced clinical evaluation has shown a Th1-skewed vaccine re- sponse and no pathologic
    > lung infiltrates.

     The Bharat Biotech vaccine paper also mentions this as one of the points that makes the vaccine
    a promising candidate worth investigating and safe enough to move into the phase 3 trial stage.


# Efficacy calculation

Here's the calculation of the actual efficacy percentage:

Efficacy = 1 - (IRR<sub>vaccine</sub> / IRR<sub>control</sub>)

where IRR<sub>vaccine</sub> = Confirmed cases in the Vaccine group / Person-years of surveillance
and   IRR<sub>control</sub> = Confirmed cases in the Control group / Person-years of surveillance

"Surveillance" is the amount of time that the trial participants were followed around for, from a
given number of days after the second dose, until the date of the data-lock. This number of days
after the second dose varies depending on the vaccine, and it was 14 days for Moderna and
AstraZeneca, whereas it was only 7 days for the Pfizer vaccine.

The efficacy is often calculated as the "primary endpoint" of these clinical trials, and includes
all the participants who tested negative for COVID19 on Day 0 (i.e. the day that they were
randomized and given the first injection). For a participant to be considered negative, they need to
test negative on the Serology test (i.e. Test for antibodies to the virus) and the Virology test
(i.e. Test for the virus, NAAT or RT-PCR). This definition is slightly different in each study, and
the numbers for the complete group, including those who were seropositive at the start of the trial
are also reported.


# Link to papers

All these papers are available under OpenAccess from the journal websites:

| Vaccine                               | Paper                                                          | NYT Vaccine Tracker                                                                                          |
|---------------------------------------|----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Oxford-AstraZeneca (2 standard doses) | [Voyset 2021](http://dx.doi.org/10.1016/s0140-6736(20)32661-1) | [AstraZeneca](https://www.nytimes.com/interactive/2020/science/coronavirus-vaccine-tracker.html#astrazeneca) |
| Pfizer                                | [Polack 2020](http://dx.doi.org/10.1056/nejmoa2034577)         | [Pfizer-BioNTech](https://www.nytimes.com/interactive/2020/science/coronavirus-vaccine-tracker.html#pfizer)  |
| Moderna                               | [Baden 2020](http://dx.doi.org/10.1056/nejmoa2035389)          | [Moderna](https://www.nytimes.com/interactive/2020/science/coronavirus-vaccine-tracker.html#moderna)         |
| Bharat Biotech (Covaxin)              | [Ella 2020](http://dx.doi.org/10.1101/2020.12.21.20248643)     | [Bharat Biotech](https://www.nytimes.com/interactive/2020/science/coronavirus-vaccine-tracker.html#bharat)   |
