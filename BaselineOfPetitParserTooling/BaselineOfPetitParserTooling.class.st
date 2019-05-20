"
baseline
"
Class {
	#name : #BaselineOfPetitParserTooling,
	#superclass : #BaselineOf,
	#category : #BaselineOfPetitParserTooling
}

{ #category : #baselines }
BaselineOfPetitParserTooling >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Packages" spec package: 'PetitParserTooling-Core' ].
	spec
		for: #petitParser2
		do: [ spec package: 'PetitParserTooling-PP2' ]
]
