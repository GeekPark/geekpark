require 'rails_helper'

RSpec.describe DelayedPublishJob, type: :job do
  include ActiveJob::TestHelper

  let(:model) { create(:post, :draft) }
  subject(:job) { described_class }

  it 'queues the job' do
    expect { job.perform_later(model) }.to change {
      ActiveJob::Base.queue_adapter.enqueued_jobs.size
    }.by(1)
  end

  it 'executes the action' do
    perform_enqueued_jobs { job.perform_now(model) }
    expect(model).to be_published
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
