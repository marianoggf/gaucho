shared_examples_for 'response with no content' do
  it { expect(response).to have_http_status(:no_content) }
  it { expect(response.content_type).to equal(nil) }
end

shared_examples_for 'unprocessable entity' do
  it { expect(response).to have_http_status(:unprocessable_entity) }
  it { expect(response.content_type).to eq(Mime::JSON) }
end

shared_examples_for 'all instances returner' do
  it { expect(response).to have_http_status(:ok) }
  it { expect(json[:data].count).to eq(subject.count) }
end

shared_examples_for 'self returner when destroyed' do
  it 'returns itself when destroyed' do
    expect(subject.destroy).to equal(subject)
  end
end 

shared_examples_for 'falsy and error setter' do |message|
  it 'returns false and sets error message' do
    expect(subject.destroy).to equal(false)
    expect(subject.errors[:delete]).to include message
  end
end 