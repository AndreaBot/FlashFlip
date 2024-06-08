# FlashFlip
<img src="https://github.com/AndreaBot/FlashFlip/assets/128467098/68ceaf88-a78a-4443-a61a-af28180f8588" alt="1024" width="180">

FlashFlip is an ap to create flash cards to study and revise any topic.

This app was created as part of Swift24 first hackathon event (https://swift24.dev)

Using SwiftData as the persistance framework, cards are organised in folders and decks.

When creating a new folder, the user is prompted to give it a name, a color and an icon, all of which carry over to the next screens to achieve a consistant look and feel.

<img width="220" alt="Screenshot 2024-06-08 at 11 29 27" src="https://github.com/AndreaBot/FlashFlip/assets/128467098/a8dc7843-9db5-4268-bce5-812043149928">
<img width="220" alt="Screenshot 2024-06-08 at 11 20 03" src="https://github.com/AndreaBot/FlashFlip/assets/128467098/fa85223b-8493-4a0e-b388-beefcae345a0">
<img width="220" alt="Screenshot 2024-06-08 at 11 20 15" src="https://github.com/AndreaBot/FlashFlip/assets/128467098/d2aa06ae-e3d5-4e9f-9d57-fef208685088">
<img width="220" alt="Screenshot 2024-06-08 at 11 21 48" src="https://github.com/AndreaBot/FlashFlip/assets/128467098/66ebb011-35b7-4f90-b0ce-a8a554570693">

Both decks and folders have option to being edited, these are accessed through a menu button at the top-right corner of the screen:

<img width="400" alt="Screenshot 2024-06-08 at 11 24 11" src="https://github.com/AndreaBot/FlashFlip/assets/128467098/0986e46f-f552-4a3f-99d7-784b00681f9a">

When browsing a deck, the user has access to its stack of cards, its stats and options to start a study session or revise weak cards.

When browsing cards, they are presented with a custom carousel view, from there the user is able to scroll through each one of them and view how many times the card has been marked as right and wrong, as well as options to edit it and delete it.

<img width="220" alt="Screenshot 2024-06-08 at 11 22 07" src="https://github.com/AndreaBot/FlashFlip/assets/128467098/5f29a05d-0226-4ad7-9598-7aa66c784a31">

The study session takes all available cards in the deck and shuffles them, they are then presented in a stack.
The user can mark each card as answered correctly or incorrectly using the buttons at the bottom of the screen.

To enhance the user experience I have implemented a series of custom animations:

- when a card is tapped, it gets flipped to reveal the answer
- marking a card as right or wrong makes it slide across the screen and change its color to green and red respectively.
- marking a card as correct slides it to the left, marking it as wrong slides it to the right
- the next cards on the stack also gets revealed with clean custom animation that changes its offset, scale and rotation as it moves to the top of stack.

https://github.com/AndreaBot/FlashFlip/assets/128467098/e4a8e6dc-7685-4cf5-b28b-bb894068c36c

For a more focused study session, the user can choose the option to revise weak cards, these include cards that have been marked wrong over 50% of the time.

At the end of the session, an end screen shows the final results and separates the cards that have been marked as right and wrong.

<img width="220" alt="Screenshot 2024-06-08 at 11 23 35" src="https://github.com/AndreaBot/FlashFlip/assets/128467098/f3416355-9380-464c-8e13-df2c782644f1">
