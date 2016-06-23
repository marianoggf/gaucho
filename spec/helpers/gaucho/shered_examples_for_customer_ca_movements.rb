shared_examples_for 'neighbour' do
  context '#previous' do
    context 'without previous movement' do
      subject{ previous }
      its(:previous) { should be nil}
      its(:previous_balance) { should eq 0 }
    end
    context 'with one previous movement' do
      subject { middle }
      its(:previous) { should eq(previous) }
      its(:previous_balance) { should eq 100 }
    end
    context 'with two previous movement' do
      subject { following }
      its(:previous) { should eq(middle) }
      its(:previous_balance) { should eq 300 }
    end
  end

  context '#following' do
    context 'without following movement' do
      subject { following }
      its(:following) { should be nil}
      its(:previous_balance) { should eq 300 }
    end
    context 'with one following movement' do    
      subject{ middle }    
      its(:following) { should eq(following) }
      its(:previous_balance) { should eq 100 }
    end
    context 'with two following movement' do    
      subject{ previous }    
      its(:following) { should eq(middle) }
      its(:previous_balance) { should eq 0 }
    end
  end
end