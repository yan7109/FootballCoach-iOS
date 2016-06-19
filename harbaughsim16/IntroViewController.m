//
//  IntroViewController.m
//  harbaughsim16
//
//  Created by Akshay Easwaran on 3/18/16.
//  Copyright © 2016 Akshay Easwaran. All rights reserved.
//

#import "IntroViewController.h"
#import "TeamSelectionViewController.h"
#import "League.h"
#import "Team.h"
#import "AppDelegate.h"
@import SafariServices;

NSString *leaguePlayerNames = @"Tim, James, John, Robert, Michael, William, David, Richard, Charles, Joseph, Thomas, Daniel, Paul, Mark, Donald, George, Steven, Edward, Brian, Ronald, Anthony, Kevin, Jason, Johnson, Matthew, Jose, Larry, Frank, Scott, Eric, Andrew, Raymond, Joshua, Jerry, Dennis, Walter, Patrick, Peter, Harold, Douglas, Henry, Carl, Arthur, Ryan, Joe, Juan, Jack, Albert, Justin, Terry, Gerald, Samuel, Ralph, Roy, Ben, Bruce, Adam, Harry, Fred, Wayne, Billy, Jeremy, Aaron, Carlos, Russell, Bobby, Alan, Jimmy, Lebron, Kobe, Brady, Manning, Peyton, Eli, Beckham, Draymond, Jordan, Derrick, Dirk, Tim, Adrian, Ha-Ha, Hunter, Dick, Blewitt, Thor, Andre, Benton, Alwan, Carnell, Clayton, Clifton, Dajon, Damon, Damarco, Damon, Cordell, Darik, Delroy, Deon, Dequain, Dexter, Dontrell, Hakeem, Jamaar, Jahquil, Jarvis, Javan, Kaynard, Kendrick, Keon, Lamar, Lavon, Lucius, Luther, Malik, Marvin, Odell, Omari, Omarr, Orlando, Otis, Perry, Quinton, Randall, Reggie, Rodell, Rondall, Rufus, Shawnte, Spike, Talin, Trayvon, Tupac, Tre, Tyree, Tyrell, Tyronne, Umar, Vashan, Wendell, Wardell, Theo,Aaron,Abel,Abraham,Adam,Adan,Adolfo,Adolph,Adrian,Agustin,Al,Alan,Albert,Alberto,Alejandro,Alex,Alexander,Alexis,Alfonso,Alfred,Alfredo,Ali,Allan,Allen,Alonzo,Alphonso,Alton,Alvaro,Alvin,Amos,Andre,Andres,Andrew,Andy,Angel,Angelo,Anthony,Antoine,Anton,Antonio,Antony,Archie,Armand,Armando,Arnold,Arron,Art,Arthur,Arturo,Ashley,Aubrey,August,Aurelio,Austin,Avery,Barney,Barry,Bart,Basil,Beau,Ben,Benito,Benjamin,Bennett,Bennie,Benny,Bernard,Bernardo,Bernie,Bert,Bill,Billie,Billy,Blaine,Blair,Blake,Bob,Bobbie,Bobby,Booker,Boyd,Brad,Bradford,Bradley,Brady,Brain,Branden,Brandon,Brendan,Brent,Bret,Brett,Brian,Brock,Bruce,Bruno,Bryan,Bryant,Bryce,Bryon,Buddy,Buford,Burton,Byron,Caleb,Calvin,Cameron,Carey,Carl,Carlo,Carlos,Carlton,Carmelo,Carmen,Carroll,Carson,Carter,Cary,Casey,Cecil,Cedric,Cesar,Chad,Charles,Charley,Charlie,Chase,Chester,Chris,Christian,Christopher,Chuck,Clair,Clarence,Clark,Claude,Clay,Clayton,Clement,Cleo,Cleveland,Cliff,Clifford,Clifton,Clint,Clinton,Clyde,Cody,Colby,Cole,Colin,Collin,Conrad,Corey,Cornelius,Cornell,Cory,Courtney,Coy,Craig,Cruz,Curt,Curtis,Dale,Dallas,Dalton,Damian,Damien,Damon,Dan,Dana,Dane,Danial,Daniel,Danny,Dante,Daren,Darin,Darius,Darnell,Darrel,Darrell,Darren,Darrin,Darryl,Darwin,Daryl,Dave,David,Davis,Dean,Delbert,Delmar,Demetrius,Denis,Dennis,Denny,Denver,Derek,Derick,Derrick,Desmond,Devin,Devon,Dewayne,Dewey,Dexter,Dick,Diego,Dion,Dirk,Domingo,Dominic,Dominick,Dominique,Don,Donald,Donnell,Donnie,Donny,Donovan,Doug,Douglas,Doyle,Drew,Duane,Dudley,Dustin,Dwayne,Dwight,Dylan,Earl,Earnest,Ed,Eddie,Eddy,Edgar,Edmond,Edmund,Eduardo,Edward,Edwardo,Edwin,Efrain,Elbert,Eldon,Eli,Elias,Elijah,Elliot,Elliott,Ellis,Elmer,Elton,Elvin,Elvis,Elwood,Emanuel,Emerson,Emery,Emil,Emilio,Emmanuel,Emmett,Emory,Enrique,Eric,Erick,Erik,Ernest,Ernesto,Ernie,Errol,Ervin,Erwin,Esteban,Ethan,Eugene,Evan,Everett,Fabian,Federico,Felipe,Felix,Fernando,Fidel,Fletcher,Floyd,Forrest,Francis,Francisco,Frank,Frankie,Franklin,Fred,Freddie,Freddy,Frederic,Frederick,Fredrick,Gabriel,Gale,Galen,Garland,Garrett,Garry,Gary,Gavin,Genaro,Gene,Geoffrey,George,Gerald,Gerard,Gerardo,German,Gerry,Gilbert,Gilberto,Glen,Glenn,Gonzalo,Gordon,Grady,Graham,Grant,Greg,Gregg,Gregorio,Gregory,Grover,Guadalupe,Guillermo,Gus,Gustavo,Guy,Hal,Hans,Harlan,Harley,Harold,Harris,Harrison,Harry,Harvey,Heath,Hector,Henry,Herbert,Heriberto,Herman,Hiram,Hollis,Homer,Horace,Houston,Howard,Hubert,Hugh,Hugo,Humberto,Hung,Hunter,Ian,Ignacio,Ira,Irvin,Irving,Irwin,Isaac,Isaiah,Isidro,Ismael,Israel,Issac,Ivan,Jack,Jackie,Jackson,Jacob,Jacques,Jaime,Jake,Jamal,Jame,James,Jamie,Jan,Jared,Jarrod,Jarvis,Jason,Jasper,Javier,Jay,Jayson,Jean,Jeff,Jefferson,Jeffery,Jeffrey,Jeffry,Jerald,Jeremiah,Jeremy,Jermaine,Jerome,Jerry,Jess,Jesse,Jessie,Jesus,Jim,Jimmie,Jimmy,Joan,Joaquin,Jody,Joe,Joel,Joesph,Joey,John,Johnathan,Johnathon,Johnnie,Johnny,Jon,Jonathan,Jonathon,Jordan,Jorge,Jose,Joseph,Josh,Joshua,Josue,Juan,Julian,Julio,Julius,Junior,Justin,Karl,Keith,Kelly,Kelvin,Ken,Kendall,Kendrick,Kenneth,Kenny,Kent,Kermit,Kerry,Kevin,Kim,Kirby,Kirk,Kris,Kristopher,Kurt,Kurtis,Kyle,Lamar,Lamont,Lance,Landon,Lane,Larry,Laurence,Laverne,Lawrence,Lee,Leland,Leo,Leon,Leonard,Leonardo,Leonel,Leroy,Leslie,Lester,Levi,Lewis,Lincoln,Linwood,Lionel,Lloyd,Logan,Lonnie,Loren,Lorenzo,Louie,Louis,Lowell,Loyd,Lucas,Luis,Luke,Luther,Lyle,Lynn,Mack,Malcolm,Manuel,Marc,Marcel,Marcelino,Marco,Marcos,Marcus,Mariano,Mario,Marion,Mark,Marlin,Marlon,Marshall,Martin,Marty,Marvin,Mary,Mason,Mathew,Matt,Matthew,Maurice,Mauricio,Max,Maxwell,Maynard,Melvin,Merle,Merlin,Merrill,Micah,Michael,Micheal,Michel,Mickey,Miguel,Mike,Miles,Millard,Milton,Mitchell,Mohammad,Moises,Monroe,Monte,Monty,Morgan,Morris,Moses,Murray,Myron,Nathan,Nathaniel,Neal,Ned,Neil,Nelson,Nestor,Nicholas,Nick,Nickolas,Nicolas,Noah,Noe,Noel,Nolan,Norbert,Norman,Norris,Numbers,Octavio,Odell,Oliver,Ollie,Omar,Orlando,Orville,Oscar,Otis,Otto,Owen,Pablo,Pasquale,Pat,Patrick,Paul,Pedro,Percy,Perry,Pete,Peter,Phil,Philip,Phillip,Pierre,Preston,Quentin,Quincy,Quinton,Rafael,Ralph,Ramiro,Ramon,Randal,Randall,Randolph,Randy,Raphael,Raul,Ray,Raymond,Raymundo,Reed,Reggie,Reginald,Rene,Reuben,Rex,Reynaldo,Ricardo,Richard,Rick,Rickey,Rickie,Ricky,Rigoberto,Riley,Rob,Robbie,Robby,Robert,Roberto,Robin,Rocco,Rocky,Rod,Roderick,Rodger,Rodney,Rodolfo,Rodrigo,Rogelio,Roger,Roland,Rolando,Roman,Romeo,Ron,Ronald,Ronnie,Roosevelt,Rory,Roscoe,Ross,Roy,Royce,Ruben,Rudolph,Rudy,Rufus,Russel,Russell,Rusty,Ryan,Salvador,Salvatore,Sam,Sammie,Sammy,Samuel,Sanford,Santiago,Santos,Saul,Scot,Scott,Scotty,Sean,Sebastian,Sergio,Seth,Shane,Shannon,Shaun,Shawn,Shelby,Sheldon,Shelton,Sherman,Sidney,Silas,Simon,Solomon,Son,Sonny,Spencer,Stacey,Stacy,Stan,Stanley,Stefan,Stephan,Stephen,Sterling,Steve,Steven,Stewart,Stuart,Sylvester,Taylor,Ted,Teddy,Terence,Terrance,Terrell,Terrence,Terry,Thaddeus,Theodore,Theron,Thomas,Thurman,Tim,Timmy,Timothy,Toby,Todd,Tom,Tomas,Tommie,Tommy,Tony,Tracy,Travis,Trent,Trenton,Trevor,Tristan,Troy,Truman,Ty,Tyler,Tyrone,Tyson,Ulysses,Van,Vance,Vaughn,Vern,Vernon,Vicente,Victor,Vince,Vincent,Virgil,Vito,Wade,Wallace,Walter,Ward,Warren,Wayne,Weldon,Wendell,Wesley,Wilbert,Wilbur,Wiley,Wilford,Wilfred,Wilfredo,Will,Willard,William,Williams,Willie,Willis,Wilmer,Wilson,Winfred,Winston,Wm,Woodrow,Xavier,Zachary,Zachery,Isaac,Squires,Cartwright,Towers,Devonta,Hopkins,Scheller,Gonzalez,Ricardo,Connor,Conner,Kirk,Tiberius,Jordan,Michael,Jackson,McGee,Sulu,Chekov,Harrison,Khan,Foxx,Keanu,Jarvis,Bourne,Reagan,Chipper,Jones,Trump,Rubio,Marquis,Micah,Ali,Richt,Johnson,McElwain,Meyer,Saban,Mullen,Morgan,Harbaugh,Foster,Beamer,Shaw,Orgeron,Tuberville,Malzahn,Fisher,Strong,O'Brien,Callahan,Dodd,Smart,Kirby,Eason,Kanye,Drake,Archer,Hikaru,Bolton,Greisinger,Meitin,Brolly,Gallagher,Agnew,Hutchinson,McClure,Harmon,Harmond";

@interface IntroViewController () <SFSafariViewControllerDelegate>

@end

@implementation IntroViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[HBSharedUtils styleColor]];
}

-(IBAction)pushTutorial:(id)sender {
    SFSafariViewController *safVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://github.com/akeaswaran/FootballCoach-iOS/blob/master/README.md"]];
    [safVC setDelegate:self];
    [self presentViewController:safVC animated:YES completion:nil];
}

-(IBAction)newDynasty {
    [self.navigationController pushViewController:[[TeamSelectionViewController alloc] initWithLeague:[League newLeagueFromCSV:leaguePlayerNames]] animated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
