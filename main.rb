# Exercise 5 Part 1 (Exception Handling)

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

def audit_sanity(bedtime_mental_state)
  return 0 unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else
    MorningMentalState.new(:not_ok)
  end
end

if audit_sanity(bedtime_mental_state) == 0
  raise "External service offline exception"
else
  new_state = audit_sanity(bedtime_mental_state)
end


# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  return 0 unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else
    MorningMentalState.new(:not_ok)
  end
end
if audit_sanity(bedtime_mental_state) == 0
  raise "External service offline exception"
else
  new_state = audit_sanity(bedtime_mental_state)
  new_state.do_work
end


# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

machine = LocalCandyMachine.new
begin
  machine.make!
end

class LocalCandyMachine
  inner_machine = CandyMachine.new
  inner_machine.prepare

  def make!
    if inner_machine.ready?
      inner_machine.make!
    else
      raise "Candy machine not ready exception"
    end
  end
end
