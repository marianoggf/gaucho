shared_examples_for 'falsy and error setter' do
  it 'returns false and sets error message' do
    expect(subject.destroy).to equal(false)
    expect(subject.errors[:data].count).not_to eq nil
  end
end

shared_examples_for 'self returner when destroyed' do
  it 'returns itself when destroyed' do
    expect(subject.destroy).to equal(subject)
  end
end 
