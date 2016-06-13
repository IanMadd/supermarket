require 'rails_helper'

describe CollaboratorWorker do
  let(:cw) { CollaboratorWorker.new() }

  it 'calls Supermarket API for collaborator count' do
    cookbook_name = "greatcookbook"
    uri = 'https://supermarket.chef.io/api/v1/cookbooks'
    expect(Net::HTTP).to receive(:post_form).with(uri, cookbook_name)
    cw.get_collaborators(cookbook_name)
  end

  it 'checks whether coookbook version passes collaborator metrics' do
    expect(cw.sufficient_collaborators?(2)).to eql(true)
    expect(cw.sufficient_collaborators?(1)).to eql(false)
  end

  # it 'sends a post request to the results endpoint' do
  #   FoodcriticWorker.new.perform(
  #     'cookbook_artifact_url' => 'http://example.com/apache.tar.gz',
  #     'cookbook_name' => 'apache2',
  #     'cookbook_version' => '1.2.0'
  #   )

  #   assert_requested(:post, ENV['FIERI_RESULTS_ENDPOINT'], times: 1) do |req|
  #     req.body =~ /foodcritic_failure=true/
  #     req.body =~ /FC023/
  #   end
  # end

  # it 'creates a unique directory for each job to work within' do
  #   Sidekiq::Testing.inline! do
  #     job_id_1 = FoodcriticWorker.perform_async(
  #       'cookbook_artifact_url' => 'http://example.com/apache.tar.gz',
  #       'cookbook_name' => 'apache2',
  #       'cookbook_version' => '1.2.0'
  #     )

  #     job_id_2 = FoodcriticWorker.perform_async(
  #       'cookbook_artifact_url' => 'http://example.com/apache.tar.gz',
  #       'cookbook_name' => 'apache2',
  #       'cookbook_version' => '1.2.0'
  #     )

  #     assert Dir.exist?(File.join(Dir.tmpdir, job_id_1))
  #     assert Dir.exist?(File.join(Dir.tmpdir, job_id_2))
  #   end
end
