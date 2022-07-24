require 'spec_helper'
require 'rpictogrify'

describe Rpictogrify do
  after do
    Rpictogrify.reset_config
  end

  context 'configure' do
    it 'load default config' do
      expect(Rpictogrify.config.theme).to eq(:monsters)
      expect(Rpictogrify.config.base_path).to eq('public/system')
    end

    it 'change after configure' do
      Rpictogrify.configure do
        self.theme     = :avataars_female
        self.base_path = 'public'
      end

      expect(Rpictogrify.config.theme).to eq(:avataars_female)
      expect(Rpictogrify.config.base_path).to eq('public')
    end

    it 'register theme' do
      custom_theme_assets_path = 'vendor/assets/rpictogrify/themes/custom'
      expect(defined?(Rpictogrify::Themes::Custom)).to be_falsy

      Rpictogrify.configure do
        self.theme     = :custom
        self.register_theme :custom, assets_path: custom_theme_assets_path
      end

      expect(defined?(Rpictogrify::Themes::Custom)).to be_truthy
      expect(Rpictogrify::Themes::Custom.superclass).to eq Rpictogrify::Themes::Base
      expect(Rpictogrify::Themes::Custom.assets_path).to eq Pathname.new(custom_theme_assets_path)
      expect(Rpictogrify.config.theme).to eq(:custom)

      Rpictogrify.configure do
        self.register_theme :monsters, assets_path: Pathname.new(custom_theme_assets_path)
      end
      expect(Rpictogrify::Themes::Monsters.assets_path).to eq Pathname.new(custom_theme_assets_path)
      expect(Rpictogrify::Themes::Monsters.superclass).to eq Rpictogrify::Themes::Base
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
    end

    it 'return pictogram path with custom theme' do
      Rpictogrify.configure do
        self.register_theme :custom, assets_path: 'assets/themes/male_flat'
      end

      path = Rpictogrify.generate 'jim.cheung', theme: :custom
      expect(path).to include('custom')
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
