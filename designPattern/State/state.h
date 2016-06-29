#include <string>

class StateMachine;
class State;

class StateMachine {
public:
    StateMachine();
    ~StateMachine();
    void Execute();
    void SetState(State* s);
    State* GetState();
private:
    State* state;
};

class State {
public:
    virtual ~State(){};
    virtual void Execute(StateMachine *sm) = 0;
};

class StateA : public State {
public:
    void Execute(StateMachine *sm);
};

class StateB : public State {
public:
    void Execute(StateMachine *sm);
};

class StateC : public State {
public:
    void Execute(StateMachine *sm);
};
