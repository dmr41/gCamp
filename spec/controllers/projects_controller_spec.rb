require 'rails_helper'

describe  ProjectsController do

  describe '#destroy' do

    it 'does not allow a non-user to delete a project' do
    end

    it 'does not allow member of a project to delete a project' do
    end

    it 'allows an owner of a project to delete a project' do
    end

  end

end
