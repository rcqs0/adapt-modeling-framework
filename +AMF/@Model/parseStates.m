function this = parseStates(this)

if ~isempty(this.dataset)
    [dd, ~] = getInterpData(this.dataset, 0, 'spline');
    d = getDataStruct(this.dataset);
end

for comp = this.states
    
    if isa(comp.initExpr, 'char')
        dataCompName = comp.initExpr;
        comp.init = dd(d.d.(dataCompName));
    end
end

this.result.xinit = [this.states.init];
this.result.xcurr = [this.states.init];