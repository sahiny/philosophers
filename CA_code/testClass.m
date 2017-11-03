classdef testClass < handle
    events
        testevent
    end

    methods
        function obj = testClass
            lh = obj.addlistener('testevent', @obj.respond);
            lh.Recursive = true;
        end
        function raise(obj)
            notify(obj,'testevent');
        end
        function respond(obj, varargin)
            fprintf('Responded!\n');
            obj.raise();
        end
    end
end