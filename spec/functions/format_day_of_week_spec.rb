require 'spec_helper'

describe 'format_day_of_week' do
  context '=> lowercase format' do
    context '=> 1-2 letter abbreviations' do
      it {
        should run.with_params('m').and_return('monday')
        should run.with_params('t').and_return('tuesday')
        should run.with_params('w').and_return('wednesday')
        should run.with_params('th').and_return('thursday')
        should run.with_params('f').and_return('friday')
        should run.with_params('s').and_return('saturday')
        should run.with_params('su').and_return('sunday')
        should run.with_params('sn').and_return('sunday')
      }
    end
    context '=> 3 letter abbreviations' do
      it {
        should run.with_params('mon').and_return('monday')
        should run.with_params('tue').and_return('tuesday')
        should run.with_params('wed').and_return('wednesday')
        should run.with_params('thu').and_return('thursday')
        should run.with_params('fri').and_return('friday')
        should run.with_params('sat').and_return('saturday')
        should run.with_params('sun').and_return('sunday')
      }
    end
    context '=> no abbreviations' do
      it {
        should run.with_params('monday').and_return('monday')
        should run.with_params('tuesday').and_return('tuesday')
        should run.with_params('wednesday').and_return('wednesday')
        should run.with_params('thursday').and_return('thursday')
        should run.with_params('friday').and_return('friday')
        should run.with_params('saturday').and_return('saturday')
        should run.with_params('sunday').and_return('sunday')
      }
    end
    context '=> length of 3 characters' do
      it {
        should run.with_params('monday',nil,3).and_return('mon')
        should run.with_params('tue',nil,3).and_return('tue')
        should run.with_params('w',nil,3).and_return('wed')
        should run.with_params('thu',nil,3).and_return('thu')
        should run.with_params('f',nil,3).and_return('fri')
        should run.with_params('saturday',nil,3).and_return('sat')
        should run.with_params('sn',nil,3).and_return('sun')
      }
    end
    context '=> length < 1 handled gracefully' do
      it {
        should run.with_params('monday',nil,-1).and_return('monday')
        should run.with_params('tue',nil,-1).and_return('tuesday')
        should run.with_params('w',nil,-1).and_return('wednesday')
        should run.with_params('thu',nil,-1).and_return('thursday')
        should run.with_params('f',nil,-1).and_return('friday')
        should run.with_params('saturday',nil,-1).and_return('saturday')
        should run.with_params('sn',nil,-1).and_return('sunday')
      }
    end
  end # lowercase format

  context '=> capitalize format' do
    context '=> 1-2 letter abbreviations' do
      it {
        should run.with_params('m','capitalize').and_return('Monday')
        should run.with_params('t','capitalize').and_return('Tuesday')
        should run.with_params('w','capitalize').and_return('Wednesday')
        should run.with_params('th','capitalize').and_return('Thursday')
        should run.with_params('f','capitalize').and_return('Friday')
        should run.with_params('s','capitalize').and_return('Saturday')
        should run.with_params('su','capitalize').and_return('Sunday')
        should run.with_params('sn','capitalize').and_return('Sunday')
      }
    end
    context '=> 3 letter abbreviations' do
      it {
        should run.with_params('mon','capitalize').and_return('Monday')
        should run.with_params('tue','capitalize').and_return('Tuesday')
        should run.with_params('wed','capitalize').and_return('Wednesday')
        should run.with_params('thu','capitalize').and_return('Thursday')
        should run.with_params('fri','capitalize').and_return('Friday')
        should run.with_params('sat','capitalize').and_return('Saturday')
        should run.with_params('sun','capitalize').and_return('Sunday')
      }
    end
    context '=> no abbreviations' do
      it {
        should run.with_params('monday','capitalize').and_return('Monday')
        should run.with_params('tuesday','capitalize').and_return('Tuesday')
        should run.with_params('wednesday','capitalize').and_return('Wednesday')
        should run.with_params('thursday','capitalize').and_return('Thursday')
        should run.with_params('friday','capitalize').and_return('Friday')
        should run.with_params('saturday','capitalize').and_return('Saturday')
        should run.with_params('sunday','capitalize').and_return('Sunday')
      }
    end
    context '=> length of 3 characters' do
      it {
        should run.with_params('monday','capitalize',3).and_return('Mon')
        should run.with_params('tue','capitalize',3).and_return('Tue')
        should run.with_params('w','capitalize',3).and_return('Wed')
        should run.with_params('thu','capitalize',3).and_return('Thu')
        should run.with_params('f','capitalize',3).and_return('Fri')
        should run.with_params('saturday','capitalize',3).and_return('Sat')
        should run.with_params('sn','capitalize',3).and_return('Sun')
      }
    end
    context '=> length < 1 handled gracefully' do
      it {
        should run.with_params('monday','capitalize',-1).and_return('Monday')
        should run.with_params('tue','capitalize',-1).and_return('Tuesday')
        should run.with_params('w','capitalize',-1).and_return('Wednesday')
        should run.with_params('thu','capitalize',-1).and_return('Thursday')
        should run.with_params('f','capitalize',-1).and_return('Friday')
        should run.with_params('Saturday','capitalize',-1).and_return('Saturday')
        should run.with_params('sn','capitalize',-1).and_return('Sunday')
      }
    end
  end # capitalize format

  context '=> uppercase format' do
    context '=> 1-2 letter abbreviations' do
      it {
        should run.with_params('m','uppercase').and_return('MONDAY')
        should run.with_params('t','uppercase').and_return('TUESDAY')
        should run.with_params('w','uppercase').and_return('WEDNESDAY')
        should run.with_params('th','uppercase').and_return('THURSDAY')
        should run.with_params('f','uppercase').and_return('FRIDAY')
        should run.with_params('s','uppercase').and_return('SATURDAY')
        should run.with_params('su','uppercase').and_return('SUNDAY')
        should run.with_params('sn','uppercase').and_return('SUNDAY')
      }
    end
    context '=> 3 letter abbreviations' do
      it {
        should run.with_params('mon','uppercase').and_return('MONDAY')
        should run.with_params('tue','uppercase').and_return('TUESDAY')
        should run.with_params('wed','uppercase').and_return('WEDNESDAY')
        should run.with_params('thu','uppercase').and_return('THURSDAY')
        should run.with_params('fri','uppercase').and_return('FRIDAY')
        should run.with_params('sat','uppercase').and_return('SATURDAY')
        should run.with_params('sun','uppercase').and_return('SUNDAY')
      }
    end
    context '=> no abbreviations' do
      it {
        should run.with_params('monday','uppercase').and_return('MONDAY')
        should run.with_params('tuesday','uppercase').and_return('TUESDAY')
        should run.with_params('wednesday','uppercase').and_return('WEDNESDAY')
        should run.with_params('thursday','uppercase').and_return('THURSDAY')
        should run.with_params('friday','uppercase').and_return('FRIDAY')
        should run.with_params('saturday','uppercase').and_return('SATURDAY')
        should run.with_params('sunday','uppercase').and_return('SUNDAY')
      }
    end
    context '=> length of 3 characters' do
      it {
        should run.with_params('monday','uppercase',3).and_return('MON')
        should run.with_params('tue','uppercase',3).and_return('TUE')
        should run.with_params('w','uppercase',3).and_return('WED')
        should run.with_params('thu','uppercase',3).and_return('THU')
        should run.with_params('f','uppercase',3).and_return('FRI')
        should run.with_params('saturday','uppercase',3).and_return('SAT')
        should run.with_params('sn','uppercase',3).and_return('SUN')
      }
    end
    context '=> length < 1 handled gracefully' do
      it {
        should run.with_params('monday','uppercase',-1).and_return('MONDAY')
        should run.with_params('tue','uppercase',-1).and_return('TUESDAY')
        should run.with_params('w','uppercase',-1).and_return('WEDNESDAY')
        should run.with_params('thu','uppercase',-1).and_return('THURSDAY')
        should run.with_params('f','uppercase',-1).and_return('FRIDAY')
        should run.with_params('saturday','uppercase',-1).and_return('SATURDAY')
        should run.with_params('sn','uppercase',-1).and_return('SUNDAY')
      }
    end
  end # uppercase format

  context '=> other format' do
    format = {
      'monday'    => 'MoN',
      'tuesday'   => 'TuE',
      'wednesday' => 'WeD',
      'thursday'  => 'ThU',
      'friday'    => 'FrI',
      'saturday'  => 'SaT',
      'sunday'    => 'SuN',
    }
    context '=> 1-2 letter abbreviations' do
      it {
        should run.with_params('m','other',nil,format).and_return('MoN')
        should run.with_params('t','other',nil,format).and_return('TuE')
        should run.with_params('w','other',nil,format).and_return('WeD')
        should run.with_params('th','other',nil,format).and_return('ThU')
        should run.with_params('f','other',nil,format).and_return('FrI')
        should run.with_params('s','other',nil,format).and_return('SaT')
        should run.with_params('su','other',nil,format).and_return('SuN')
        should run.with_params('sn','other',nil,format).and_return('SuN')
      }
    end
    context '=> 3 letter abbreviations' do
      it {
        should run.with_params('mon','other',nil,format).and_return('MoN')
        should run.with_params('tue','other',nil,format).and_return('TuE')
        should run.with_params('wed','other',nil,format).and_return('WeD')
        should run.with_params('thu','other',nil,format).and_return('ThU')
        should run.with_params('fri','other',nil,format).and_return('FrI')
        should run.with_params('sat','other',nil,format).and_return('SaT')
        should run.with_params('sun','other',nil,format).and_return('SuN')
      }
    end
    context '=> no abbreviations' do
      it {
        should run.with_params('monday','other',nil,format).and_return('MoN')
        should run.with_params('tuesday','other',nil,format).and_return('TuE')
        should run.with_params('wednesday','other',nil,format).and_return('WeD')
        should run.with_params('thursday','other',nil,format).and_return('ThU')
        should run.with_params('friday','other',nil,format).and_return('FrI')
        should run.with_params('saturday','other',nil,format).and_return('SaT')
        should run.with_params('sunday','other',nil,format).and_return('SuN')
      }
    end
    context '=> length of 3 characters' do
      it {
        should run.with_params('monday','other',3,format).and_return('MoN')
        should run.with_params('tue','other',3,format).and_return('TuE')
        should run.with_params('w','other',3,format).and_return('WeD')
        should run.with_params('thu','other',3,format).and_return('ThU')
        should run.with_params('f','other',3,format).and_return('FrI')
        should run.with_params('saturday','other',3,format).and_return('SaT')
        should run.with_params('sn','other',3,format).and_return('SuN')
      }
    end
    context '=> length < 1 handled gracefully' do
      it {
        should run.with_params('monday','other',-1,format).and_return('MoN')
        should run.with_params('tue','other',-1,format).and_return('TuE')
        should run.with_params('w','other',-1,format).and_return('WeD')
        should run.with_params('thu','other',-1,format).and_return('ThU')
        should run.with_params('f','other',-1,format).and_return('FrI')
        should run.with_params('saturday','other',-1,format).and_return('SaT')
        should run.with_params('sn','other',-1,format).and_return('SuN')
      }
    end
  end # other format
end
