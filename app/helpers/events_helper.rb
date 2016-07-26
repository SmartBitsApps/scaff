module EventsHelper
    
  def event_brigade_sum(event)
    
    @brigades = Brigade.joins(:event).where(:brigades => { :event_id => event.id })
    @sum = @brigades.all.map(&:quantity).inject(:+) || 0
  end
  
  def available_positions(brigade)
    @brigade = brigade
    @subscriptions = Subscription.joins(:brigade).where(:subscriptions => { :brigade_id => brigade.id })
    @sum = @subscriptions.all.count
    
    @brigade.quantity - @sum
    #return available
  end
end
