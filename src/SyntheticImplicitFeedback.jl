module SyntheticImplicitFeedback

export Rule, generate

type Rule
    # return bool
    f::Function

    # if f returns true, accumulative CTR is lifted p%
    p::Float64
end

function generate(samples::Array{Dict,1}, rules::Array{Rule,1})
    map(samples) do sample
        ctr = 0.0
        for rule in rules
            if rule.f(sample)
                ctr += rule.p
            end
        end
        rand() <= ctr
    end
end

end # module
