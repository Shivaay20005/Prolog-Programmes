% Knowledge Representation using Frames in Prolog

% Frame structure: frame(Name, Slots)
% Slots are represented as slot(Attribute, Value)

% Define a generic frame with inheritance
frame(Name, Slots) :-
    assert(frame_fact(Name, Slots)).

% Retrieve a slot value from a frame
get_slot(Frame, Slot, Value) :-
    frame_fact(Frame, Slots),
    member(slot(Slot, Value), Slots).

% Inheritance mechanism
get_slot_inherited(Frame, Slot, Value) :-
    (get_slot(Frame, Slot, Value) ->
        true
    ;
        % Check if frame has a parent
        (get_slot(Frame, isa, Parent) ->
            get_slot_inherited(Parent, Slot, Value)
        ;
            fail
        )
    ).

% Member predicate
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Create sample frames for a university domain

% Generic person frame
create_person_frame :-
    frame(person, [
        slot(name, unknown),
        slot(age, unknown),
        slot(gender, unknown),
        slot(occupation, unknown)
    ]).

% Student frame (inherits from person)
create_student_frame :-
    frame(student, [
        slot(isa, person),
        slot(student_id, unknown),
        slot(major, unknown),
        slot(year, unknown),
        slot(gpa, unknown)
    ]).

% Professor frame (inherits from person)
create_professor_frame :-
    frame(professor, [
        slot(isa, person),
        slot(employee_id, unknown),
        slot(department, unknown),
        slot(courses, []),
        slot(rank, unknown)
    ]).

% Course frame
create_course_frame :-
    frame(course, [
        slot(course_id, unknown),
        slot(title, unknown),
        slot(credits, unknown),
        slot(prerequisites, []),
        slot(instructor, unknown)
    ]).

% University frame
create_university_frame :-
    frame(university, [
        slot(name, unknown),
        slot(location, unknown),
        slot(established, unknown),
        slot(students, []),
        slot(faculty, []),
        slot(courses, [])
    ]).

% Create instances of frames

% Sample student instance
create_john_student :-
    frame(john_student, [
        slot(isa, student),
        slot(name, 'John Smith'),
        slot(age, 20),
        slot(gender, male),
        slot(student_id, 12345),
        slot(major, 'Computer Science'),
        slot(year, 'Sophomore'),
        slot(gpa, 3.75)
    ]).

% Sample professor instance
create_dr_jones_professor :-
    frame(dr_jones, [
        slot(isa, professor),
        slot(name, 'Dr. Alice Jones'),
        slot(age, 45),
        slot(gender, female),
        slot(employee_id, 98765),
        slot(department, 'Computer Science'),
        slot(courses, ['CS101', 'CS202']),
        slot(rank, 'Associate Professor')
    ]).

% Sample course instance
create_cs101_course :-
    frame(cs101, [
        slot(course_id, 'CS101'),
        slot(title, 'Introduction to Programming'),
        slot(credits, 3),
        slot(prerequisites, []),
        slot(instructor, 'Dr. Alice Jones')
    ]).

% Sample university instance
create_state_university :-
    frame(state_uni, [
        slot(name, 'State University'),
        slot(location, 'Anytown, USA'),
        slot(established, 1950),
        slot(students, ['john_student']),
        slot(faculty, ['dr_jones']),
        slot(courses, ['cs101'])
    ]).

% Query functions

% Get information about a person
get_person_info(Person) :-
    write('Information about '), write(Person), write(':'), nl,
    (get_slot_inherited(Person, name, Name) ->
        write('  Name: '), write(Name), nl
    ;
        write('  Name: unknown'), nl
    ),
    (get_slot_inherited(Person, age, Age) ->
        write('  Age: '), write(Age), nl
    ;
        write('  Age: unknown'), nl
    ),
    (get_slot_inherited(Person, gender, Gender) ->
        write('  Gender: '), write(Gender), nl
    ;
        write('  Gender: unknown'), nl
    ),
    (get_slot_inherited(Person, occupation, Occupation) ->
        write('  Occupation: '), write(Occupation), nl
    ;
        write('  Occupation: unknown'), nl
    ).

% Get student-specific information
get_student_info(Student) :-
    get_person_info(Student),
    (get_slot(Student, student_id, ID) ->
        write('  Student ID: '), write(ID), nl
    ;
        write('  Student ID: unknown'), nl
    ),
    (get_slot(Student, major, Major) ->
        write('  Major: '), write(Major), nl
    ;
        write('  Major: unknown'), nl
    ),
    (get_slot(Student, year, Year) ->
        write('  Year: '), write(Year), nl
    ;
        write('  Year: unknown'), nl
    ),
    (get_slot(Student, gpa, GPA) ->
        write('  GPA: '), write(GPA), nl
    ;
        write('  GPA: unknown'), nl
    ).

% Get professor-specific information
get_professor_info(Professor) :-
    get_person_info(Professor),
    (get_slot(Professor, employee_id, ID) ->
        write('  Employee ID: '), write(ID), nl
    ;
        write('  Employee ID: unknown'), nl
    ),
    (get_slot(Professor, department, Dept) ->
        write('  Department: '), write(Dept), nl
    ;
        write('  Department: unknown'), nl
    ),
    (get_slot(Professor, rank, Rank) ->
        write('  Rank: '), write(Rank), nl
    ;
        write('  Rank: unknown'), nl
    ).

% Initialize the frame system
initialize_frames :-
    create_person_frame,
    create_student_frame,
    create_professor_frame,
    create_course_frame,
    create_university_frame,
    create_john_student,
    create_dr_jones_professor,
    create_cs101_course,
    create_state_university,
    write('Frame system initialized successfully.'), nl.

% Demonstrate frame queries
demonstrate_frames :-
    write('Frame-based Knowledge Representation Demo'), nl,
    write('========================================='), nl, nl,
    get_student_info(john_student), nl,
    get_professor_info(dr_jones), nl,
    write('Course Information:'), nl,
    get_slot(cs101, title, Title),
    write('  Course Title: '), write(Title), nl,
    get_slot(cs101, credits, Credits),
    write('  Credits: '), write(Credits), nl, nl,
    write('University Information:'), nl,
    get_slot(state_uni, name, Name),
    write('  Name: '), write(Name), nl,
    get_slot(state_uni, location, Location),
    write('  Location: '), write(Location), nl.

% Add a new slot to an existing frame
add_slot(Frame, Slot, Value) :-
    retract(frame_fact(Frame, Slots)),
    assert(frame_fact(Frame, [slot(Slot, Value)|Slots])).

% Update a slot value in a frame
update_slot(Frame, Slot, NewValue) :-
    retract(frame_fact(Frame, Slots)),
    replace_slot(Slots, Slot, NewValue, UpdatedSlots),
    assert(frame_fact(Frame, UpdatedSlots)).

% Replace a slot value
replace_slot([slot(Slot, _)|T], Slot, NewValue, [slot(Slot, NewValue)|T]) :- !.
replace_slot([H|T], Slot, NewValue, [H|RT]) :-
    replace_slot(T, Slot, NewValue, RT).

% Example usage:
% ?- initialize_frames.
% ?- demonstrate_frames.
% ?- get_slot_inherited(john_student, name, Name).
% ?- get_slot_inherited(dr_jones, age, Age).
% ?- get_student_info(john_student).