using SyntheticImplicitFeedback
using Base.Test

# create a set of rules
rules = Rule[]

push!(rules, Rule(s -> true, 0.001))
push!(rules, Rule(s -> s["Ad"] == 2, 0.01))
push!(rules, Rule(s -> s["Age"] >= 1980 && s["Age"] < 1989 && s["Geo"] == "New York" && s["Ad"] == 0, 0.30))
push!(rules, Rule(s -> s["Age"] >= 1950 && s["Age"] < 1959 && s["Geo"] == "New York" && s["Ad"] == 1, 0.30))
push!(rules, Rule(s -> s["Age"] >= 1980 && s["Age"] < 1989 && s["Geo"] == "Arizona" && s["Ad"] == 1, 0.30))
push!(rules, Rule(s -> s["Age"] >= 1950 && s["Age"] < 1959 && s["Geo"] == "Arizona" && s["Ad"] == 0, 0.30))

# generate samples with random pairs of demographics and ad variants
samples = Dict[]

age_range = 1930:2010
geos = ["Arizona", "California", "Colorado", "Illinois", "Indiana", "Michigan", "New York", "Utah"]
n_ad = 5

for i in 1:100
    sample = Dict()
    sample["Age"] = rand(age_range)
    sample["Geo"] = rand(geos)
    sample["Ad"] = rand(0:(n_ad-1))
    push!(samples, sample)
end

feedback = generate(samples, rules)

@test length(feedback) == length(samples)
