type ASRacos
    rc::RacosCommon
    evaluation_server_num
    sample_set
    result_set
    asyn_result
    history
    is_finish

    function ASRacos(ncomputer)
        new(RacosCommon(), ncomputer, RemoteChannel(()->Channel(ncomputer)),
        RemoteChannel(()->Channel(ncomputer)), RemoteChannel(()->Channel(1)),
        RemoteChannel(()->Channel(1)), false)
    end
end

function asracos_init_sample_set!(asracos::ASRacos, ub)
    rc = asracos.rc
    data_temp = rc.parameter.init_sample
    init_num = 0
    if !isnull(data_temp)
        init_num = length(data_temp)
        for i = 1:init_num
            put!(asracos.sample_set, data_temp[i])
        end
    end
    classifier = RacosClassification(rc.objective.dim, rc.positive_data,
        rc.negative_data, ub=ub)
    mixed_classification(classifier)
    for i = 1:(asracos.evaluation_server_num-init_num)
        if rand(rng, Float64) < rc.parameter.probability
            solution, distinct_flag = distinct_sample_classifier(rc, classifier, data_num=rc.parameter.train_size)
        else
            solution, distinct_flag = distinct_sample(rc, rc.objective.dim)
        end
        # sol_print(solution)
        put!(asracos.sample_set, solution)
    end
end
