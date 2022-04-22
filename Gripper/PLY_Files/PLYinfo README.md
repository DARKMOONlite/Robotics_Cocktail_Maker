
## Idiosyncrasies of Gripper PLY files
### Base of fingers
PLY files Base1 & Part0 just contain useless shapes that's only purpose is to help streamline the code. this is because the palm of the model is created seperately from the fingers, thus we need some random small model to act as the base for each of the fingers. 
### first joint of palm
Since i wanted to utilise the features already perscribed to arms, i wanted to make the wrist of the gripper an arm in itself. therefore i used the same random small model as the first joint of the wrist which shouldn't be touched