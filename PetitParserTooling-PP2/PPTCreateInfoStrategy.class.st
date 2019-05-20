"
I am the strategy to create an InfoResult, an object containing the result of the parsing and its position in the stream.
"
Class {
	#name : #PPTCreateInfoStrategy,
	#superclass : #PP2Strategy,
	#category : #'PetitParserTooling-PP2'
}

{ #category : #parsing }
PPTCreateInfoStrategy >> parseOn: aPP2Context [
	| start retval |
	start := aPP2Context position + 1.
	(retval := node child parseOn: aPP2Context) isPetit2Failure
		ifTrue: [ ^ retval ].
	^ PPTInfoResult new
		start: start;
		stop: aPP2Context position;
		content: retval;
		yourself
]
