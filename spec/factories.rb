FactoryGirl.define do
	factory :user do
		username "Pekka"
		password "Foobar1"
		password_confirmation "Foobar1"
		admin true
		frozed true
	end

	factory :rating do
		score 10
	end

	factory :rating2, class: Rating do
		score 20
	end

	factory :brewery do
		name "anonymous"
		year 1900
	end

	factory :beer do
		name "anonymous"
		brewery
		style
	end

	factory :style do
		name "Lager"
		description "Hyvää on"
	end
end
