***This tool has been migrated to [Recommendation.jl](https://github.com/takuti/Recommendation.jl). Use the package instead.***

---

# SyntheticImplicitFeedback.jl

[![Build Status](https://travis-ci.org/takuti/SyntheticImplicitFeedback.jl.svg?branch=master)](https://travis-ci.org/takuti/SyntheticImplicitFeedback.jl)

Generate a set of implicit feedback based on the pre-defined rules.

A synthetic data generation procedure is described in:

- M. Aharon, et al. **OFF-Set: One-pass Factorization of Feature Sets for Online Recommendation in Persistent Cold Start Settings**. [arXiv:1308.1792](http://arxiv.org/abs/1308.1792).

## Installation

```
$ julia
julia> Pkg.clone("git@github.com:takuti/SyntheticImplicitFeedback.jl.git")
```

## Usage

```julia
using SyntheticImplicitFeedback
```

First of all, you need to define a set of rules as:

```julia
rules = Rule[]

push!(rules, Rule(s -> true, 0.001))
push!(rules, Rule(s -> s["Ad"] == 2, 0.01))
push!(rules, Rule(s -> s["Age"] >= 1980 && s["Age"] <= 1989 && s["Geo"] == "New York" && s["Ad"] == 0, 0.30))
push!(rules, Rule(s -> s["Age"] >= 1950 && s["Age"] <= 1959 && s["Geo"] == "New York" && s["Ad"] == 1, 0.30))
push!(rules, Rule(s -> s["Age"] >= 1980 && s["Age"] <= 1989 && s["Geo"] == "Arizona" && s["Ad"] == 1, 0.30))
push!(rules, Rule(s -> s["Age"] >= 1950 && s["Age"] <= 1959 && s["Geo"] == "Arizona" && s["Ad"] == 0, 0.30))
```

Next, let us create a set of samples with random pairs of properties:

```julia
samples = Dict[]

age_range = 1950:2000
geos = ["Arizona", "California", "Illinois", "New York", "Utah"]
n_ad = 5

for i in 1:10
    sample = Dict()
    sample["Age"] = rand(age_range)
    sample["Geo"] = rand(geos)
    sample["Ad"] = rand(0:(n_ad-1))
    push!(samples, sample)
end
```

Finally, `generate()` function returns a list of implicit feedback:

```julia
feedback = generate(samples, rules)
# Bool[false,false,false,false,false,true,false,false,false,false]
```
