module SyntheticImplicitFeedback

export Rule, generate

type Rule
    # return bool
    f::Function

    # if f returns true, accumulative CTR is lifted p%
    p::Float64
end

function generate(samples::Array{Dict,1}, rules::Array{Rule,1})
    feedback = Bool[]
    for sample in samples
        ctr = 0.0
        for rule in rules
            if rule.f(sample)
                ctr += rule.p
            end
        end
        push!(feedback, rand() <= ctr)
    end
    feedback
end

end # module
