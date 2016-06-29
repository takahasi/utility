#include <iostream>
#include "state.h"

void StateA::Execute(StateMachine *sm)
{
    std::cout << "execute : A" << std::endl;
    std::cout << "state   : A->B" << std::endl;
    sm->SetState(new StateB());
}

void StateB::Execute(StateMachine *sm)
{
    std::cout << "execute : B" << std::endl;
    std::cout << "state   : B->C" << std::endl;
    sm->SetState(new StateC());
}

void StateC::Execute(StateMachine *sm)
{
    std::cout << "execute : C" << std::endl;
    std::cout << "state   : C->A" << std::endl;
    sm->SetState(new StateA());
}

StateMachine::StateMachine()
{
    state = new StateA();
}

StateMachine::~StateMachine()
{
    delete state;
}

void StateMachine::Execute()
{
    state->Execute(this);
}

void StateMachine::SetState(State* s)
{
    state = s;
}

State* StateMachine::GetState()
{
    return state;
}

int main(void)
{
    static StateMachine *sm = new StateMachine();

    for (int i = 0; i < 10; i++) {
        sm->Execute();
    }

    return 0;
}
