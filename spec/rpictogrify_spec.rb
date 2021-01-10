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
      end

      expect(Rpictogrify.config.theme).to eq(:avataars_female)
      expect(Rpictogrify.config.base_path).to eq('public')

      Rpictogrify.configure do
        self.theme     = :monsters
        self.base_path = 'public/system'
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
    end
  end
end
