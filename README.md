# Download

There's two ways of doing it:  
Trough the **Godot Asset Library**, and **GitHub**.

## Through the Godot Asset Library

This one's relatively easy. You most likely came from there.  
What you do, is go back to the **Godot Asset Library**, and then search for my product (*Car Driver 2D*) and then click on it.

> Note:
>
> Make sure you type '*Car Driver 2D*', and not 'CarDriver2D'. Otherwise, the Godot Asset Library won't find the add-on.  
> Additionally, capitalization does *NOT* matter.

Now that you have found my add-on in the *Godot Asset Library* (if you haven't already), you see (obviously the name), the add-on's tags, the description, screenshots and some buttons. They, as of now, include:  
	- 'View files'  
	- 'Download'  
	- 'Submit an Issue'  
	- 'Recent Edits'

What we're aiming for is the **Download** button. Click on that, and then your file manager should appear.  
Simply select your desired destination of the file, download it, extract it in that folder, and there you should, if you open the folder, see the add-on in the folder path and then in the *addons/cardriver2d* folder.

> Note:
> When you open the *addons* folder, you should see *car.gd* and *top_down_car.svg*.  
> If you like, you can delete the car svg, since this is only something I made quickly for testing, but I put it in if anybody likes it. :D

Then, when you'd like to add it to one of your projects (if you haven't directly added it to one yet), simply add the addons folder to your desired project and there you go!  
*That's that!*

## Trough GitHub

This one's slightly more advanced, since you will use the terminal for this tutorial, but you get slightly more out of it. Since the *Godot Asset Library* doesn't give you the *entire GitHub repository*, but only the *addons* folder.  
With the **GitHub method**, you can get your hands on the *entire project*. Since you require the terminal for this, it's easier if I write this down in concrete steps, as follows:

> __Step 1 (optional):__
>>
>> Create a *new folder*. It can be called whatever you want. Since cloning the repo via the terminal creates another folder anyway, this step is only optional.

> __Step 2:__
>>
>> Open the *terminal*.

> __Step 3:__
>>
>> Navigate into your (newly created) *folder* using the *terminal*. This folder can also simply be where your other Godot Projects are located in.  
>> Addditionally, make sure you are in that folder.

> __Step 4:__
>>
>> Type in '*gh repo clone VoxelChicken/CarDriver2D*'. This means:  
>> *GitHub repository clone VoxelChicken / CarDriver2D.*

> __Step 5:__
>>
>> Now that the repository is cloned, you can exit the terminal. Navigate into the project folder using your file manager.

> __Step 6: (optional)__
>>
>> You can manage the files to your liking. For example, you can use the project.godot file to test the add-on out and mess around with it.

This will get you the entire repository, not just the add-on. So the 'Sample project' (developer's testing space)

That's it for the *GitHub cloning* tutorial! On to the *Setting up* tutorial!



# Setting up

This is the actual *application* tutorial of the add-on. This is an overview of what it has to offer and what you can manipulate in the Godot built-in editor:

## Editor Variables (Exported Variables)

The following variables are exported variables that you can see in the built-in Godot editor, here's a list:

> Acceleration
>>
>> It controls how fast the car speeds up. The faster it is, the faster the car reaches the desired speed.  
>> (Default: 1.0)

> Break Speed
>>
>> It controls how quickly you can break. The higher the number is, the faster the car can slow down from its speed and therefore reaching the desired speed.  
>> (Default: 1.0)

> Max Speed
>>
>> It controls the highest possible speed of the car - its speed cannot pass that limit.  
>> (Default: 300.0)

> Turn Strength
>>
>> It controls the rotation of the car - the higher the turn strength is, the faster (better) the car can turn.  
>> (Default: 2.0)

> Most Ideal Turn Speed
>>
>> It controls the speed at which the car can turn best. The higher it is, the slower the car turns at lower speeds.  
>> Default: 250.0  
>> Note: This doesn't affect velocity. Only the rotation.

## Controls-Management (NECESSARY)

This is **necessary**, because you probably won't have these keys assigned to the dedicated movements.
Just follow these steps:

> Step 1:
>>
>> In your project, open the *Project Settings* in Godot.

> Step 2:
>>
>> Open the tab *Input Map*.

> Step 3: Add the action names (names don't really matter'):
>>
>> Can be named whatevery you want though, so the names in quotes are written in parameters because that's how the code is written.  
>> Note that you can also change the code. That's what we'll look at the following.
>>
>> Accelerate = ('accelerate')  
>> Decelerate = ('decelerate')  
>> Turn Right = ('turn_right')  
>> Turn Left = ('turn_left')
>>
>> Now, you can assign keys to these actions to your liking.

The better way is to look at the code itself:

First, open the *Project Settings* and open the tab *Input Map*.  
Then, add new actions (name doesn't matter) and then assign a desired key to that action. Then, go into the code (car.gd script) and do the following.

> Step 1:
>>
>> Look inside the process function.

> Step 2:
>>
>> Look at the "comment region" *input handling*.

> Step 3:
>>
>> Change the the following:
>>
>> ... = Input.get_axis("accelerate", "decelerate")  
>> ... = Input.get_axis("turn_left", "turn_right")
>>
>> to:
>>
>> ... = Input.get_axis("[your_accelerate_name]", "[your_decelerate_name]")  
>> ... = Input.get_axis("[your_turn_left_name]", "[your_turn_right_name]")

# Finishing up

For the final step - assign *car.gd* script to a **CharacterBody2D** (and that's *necessary*, since the *velocity* variable doesn't exist elseswhere as far as I know) and that's it!  
Now you can test the car!

## Any Errors?

Go to GitHub and submit a new issue under the *issues* tab in the repository for the CarDriver2D.

---

And all should be done! Have fun with the add-on! :D
