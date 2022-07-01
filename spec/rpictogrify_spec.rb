require 'spec_helper'
require 'rpictogrify'

describe Rpictogrify do
  context 'configure' do
    it 'load default config' do
      expect(Rpictogrify.config.theme).to eq(:monsters)
      expect(Rpictogrify.config.base_path).to eq('public/system')
    end

    it 'change after configure' do
      Rpictogrify.configure do
        self.theme     = :avataars_female
        self.base_path = 'public'
        self.themes_assets_path = "/somewhere"
      end

      expect(Rpictogrify.config.theme).to eq(:avataars_female)
      expect(Rpictogrify.config.base_path).to eq('public')
      expect(Rpictogrify.config.themes_assets_path).to eq('/somewhere')

      Rpictogrify.configure do
        self.theme     = :monsters
        self.base_path = 'public/system'
        self.themes_assets_path = nil
      end
    end
  end

  context 'generate' do
    it 'return pictogram path with default theme' do
      path = Rpictogrify.generate 'jim.cheung'
      expect(path).to include('monsters')
    end

    it 'return pictogram path with given theme' do
      path = Rpictogrify.generate 'jim.cheung', theme: :avataars_female
      expect(path).to include('avataars_female')
    end

    it 'return pictogram path with changed configuration' do
      Rpictogrify.configure do
        self.theme     = :avataars_female
        self.base_path = 'public/custom'
      end

      path = Rpictogrify.generate 'jim.cheung'
      expect(path).to include('avataars_female')
      expect(path).to include('public/custom')

      Rpictogrify.configure do
        self.theme     = :monsters
        self.base_path = 'public/system'
      end
    end
  end

  context 'helper' do
    include Rpictogrify::Helper

    it 'return pictogram path with rpictogrify_for' do
      expect(rpictogrify_for('jim.cheung')).to include('public/')
    end

    it 'return pictogram url with rpictogrify_url_for' do
      expect(rpictogrify_url_for(rpictogrify_for('jim.cheung'))).not_to include('public/')
    end

    it 'return pictogram url with rpictogrify_url' do
      expect(rpictogrify_url('jim.cheung')).not_to include('public/')
    end

    it 'return pictogram tag with rpictogrify_tag' do
      expect(rpictogrify_tag('jim.cheung')).to include('<img')
    end
  end

  context 'extension' do
    user_class = Class.new do
      include Rpictogrify::Extension

      rpictogrify_on :username, theme: :monsters

      def self.name
        'User'
      end

      def username
        @username ||= [*'a'..'z', *'A'..'Z'].sample(6).join
      end
    end

    it 'return pictogram path with rpictogrify_path' do
      user = user_class.new
      expect(user.rpictogrify_path).to include('public/')
    end

    it 'return pictogram url with rpictogrify_url' do
      user = user_class.new
      expect(user.rpictogrify_url).not_to include('public/')
    end
  end
end
