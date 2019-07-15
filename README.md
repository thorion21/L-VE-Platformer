# L-VE (2D platformer implemented using ECS)

## World

   Manages all entities, components and filters the according component
fields to match the system.
   Manages the insertion of a new system or removal of an already existing
one.

## Entity

   Every entity has an unique ID (even if multiple instances of the same
entity exists). Each entity is defined by its components. Entity class
only has its components mentioned and different parameters in order to
customize its personality.

## Component

   Represents a so called 'container' which values represents its entity
attributes and also, tells the system that this entity is capable of doing
something.

## System

   The system is responsible to identify and implement the behavior of
every associated component from an entity.
   An entity manager will separate every component and put them in
labeled systems (a table which key is represented by the entities ID).
This is done for performance reasons, because when a system has to update
a entity it's obvious that the impact of checking all the entities to find
that respective one which has a specific component is immensely huge.

   But what it is to do when a system requires more than just 1 component
to be able to perform it's action?
   Systems should have access to other systems data? To find if the respective
entity also possesses the second, third or any nth component that this system
needs?

   R: Every system will hold a table for every entities components that
possess an aspect of that system. More than that, it can possess all
components that matches the aspect of that particular system. Using this
approach we can avoid systems to interrogate other ones to gain data.

    Example:
        Render System
        Movement System

   The two mentioned above need a reference to the position component of
that entity. By so, if both need that information it will be pointless
to have a definition of a system that clearly is too strict (to separate
every component). In this case, a system will have ALL components that
interacts with and needs to perform its operation.

### Steps to add a new component in ECS
         1. Define the component in Component.lua;
         2. Add the component to a Prefab;
         3. Define a system that will control that component in System.lua;
         4. Fully define a system in World:GetSystems() where the function
            named above is actually bound to the components that system operates on;
         5. Finalize by connecting the system(s) and the component
            into World:GetSwitcher().

### The addition of Entity Manager and Event Manager

   Entity Manager should have a very basic function. Stores all entities,
and when interrogated by systems with an ID, it should response with the
entity associated with that respective ID.

   It easier to pass around objects or entities but it shouldn't be done.
   I'm not 100% sure about adding one right now, because the entity list
is passed just one time, in system.load(). It's kind of the same, a bit less
organized, but easier. What could be the clear advantages of doing that?
I see just a disadvantage.. having one object (EntityManager) that should
remove the entity when it is due.

   Event Manager - this is a must. If two or more systems want to communicate
they really shouldn't keep a reference one to another. Instead, to pass a
message with a tag (could be an enumerable) to an Event Manager and that
manager should filter all the received messages and pass it only to those
systems that are subscribed of listening to a message of that type.
   Exactly like Observer Pattern.
