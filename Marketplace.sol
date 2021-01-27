pragma solidity >=0.7.0 <=0.7.3;
import "Smaple.sol";
contract Marketplace{
    address payable owner;
    
    enum Expertiza{ SMALL, MEDIUM, LARGE }
    enum Status
    {
        OPEN,
        IN_PROGRESS,
        IN_WAITING,
        DISPUTE,
        FINISHED
    }
    
    struct Manager
    {
        uint256 id;
        string name;
        uint8 reputation;
        uint256 tokens;
    }
    
    struct Evaluators
    {
        uint256 id;
        string name;
        uint8 reputation;
        Expertiza categorie;
        uint256 tokens;
    }
    
    struct Freelancer
    {
        uint256 id;
        string name;
        uint8 reputation;
        Expertiza categorie;
        uint256 tokens;
    } 
    
    struct Finatator
    {
        uint256 id;
        string name;
        uint256 tokens;
    }
     
     struct Product
     {
         string descr;
         uint DEV;
         uint REV;
         uint domain;
         uint number_of_fin;
         address[] fins;
         uint256[] tokens;
         uint256 id;
         uint256 balance;
         address manager;
         
         address[] freelancers;
         uint256[] tokens_freelancer;
         uint256 number_of_freelancers;
         
         address[] freelancers_selected;
         uint256[] tokens_for_selected_freelancers;
         uint256 number_of_selected_freelancers;
         uint256 tokens_used_for_dev;
         
         address evaluator;
         
         Status progress; 
         
         bool arbitraj;
         
     }
    
     Product[] products;
    uint256 number_of_products;
    
    

    mapping(address=>Manager) managers;
    address[] managers_adress;
    uint managers_id;
    mapping(address=>Evaluators) evals;
    address[] evals_adress;
    uint evals_id;
    mapping(address=>Freelancer) frelancers;
    address[] frelancers_adress;
    uint frelancers_id;
     mapping(address=>Finatator) finans;
    address[] finans_adress;
    uint finans_id;
    
     modifier only_owner() {
        require (owner == msg.sender);
        _;
    }
    
    SampleToken public tokenContract;
    uint256 tokenPrice;
   
    constructor()
    {
        owner=msg.sender;
        managers_id=0;
        evals_id=0;
        frelancers_id=0;
        finans_id=0;
        number_of_products=0;
        tokenContract =new SampleToken(1000);
        tokenPrice = 10;
    }
    
    
    
    function buyTokens() public payable {
        owner.transfer(msg.value / tokenPrice);
        require(tokenContract.transfer(msg.sender, msg.value / tokenPrice));
    }
    
    
    function initMarketplace(address payable mngs,address payable eval,address payable frelancer , address payable finat ) public only_owner 
    {
        
        managers_adress.push(mngs);
        managers[mngs].id=managers_id;
        managers[mngs].name="first_manager";
        managers[mngs].reputation=5;
        managers_id=managers_id+1;
        
        
        evals_adress.push(eval);
        evals[eval].id=evals_id;
        evals[eval].name="first_evaluator";
        evals[eval].reputation=5;
        evals[eval].categorie=Expertiza.LARGE;
        evals_id=evals_id+1;
        
        
        frelancers_adress.push(frelancer);
        frelancers[frelancer].id=frelancers_id;
        frelancers[frelancer].name="first_freelancer";
        frelancers[frelancer].reputation=5;
        frelancers[frelancer].categorie=Expertiza.SMALL;
        frelancers_id=frelancers_id+1;
        
        
        finans_adress.push(finat);
        finans[finat].name="finataor";
        finans[finat].id=finans_id;
        finans[finat].tokens=100;
        finans_id=finans_id+1;
        
    }
    
    
    function createProduct(string calldata descr,uint cost_dez,uint recompensa)public  returns(bool){
         for(uint256 i=0;i<managers_id;i=i+1)
         {
            if(managers_adress[i]==msg.sender)
            {
                Product memory pr;
                pr.descr=descr;
                pr.number_of_fin=0;
                pr.number_of_fin=pr.number_of_fin+1;
                pr.manager=msg.sender;
                pr.DEV=cost_dez;
                pr.REV=recompensa;
                pr.id=number_of_products;
                pr.balance=0;
                pr.progress = Status.OPEN;
                pr.number_of_freelancers = 0;
                pr.evaluator = address(0);
                pr.number_of_selected_freelancers = 0;
                pr.tokens_used_for_dev = 0;
                pr.arbitraj = false;
                products.push(pr);   
                number_of_products=number_of_products+1;
                return true;
            }
         }
         revert("FAILED!");
         //return false;
    }
    
    function fintantare(uint256 pr_id,uint256 tokenss) payable public 
    {
        
      for(uint256 i=0;i < finans_id; i=i+1)
      {
            if(finans_adress[i] == msg.sender)
            {
                if(products[pr_id].balance < products[pr_id].DEV + products[pr_id].REV)
                {
                    bool fin_found=false;
                    for(uint256 j = 0 ; j < products[pr_id].number_of_fin ; j = j + 1)
                    {
                        if(products[pr_id].fins[j]==msg.sender)
                        {
                            fin_found = true;
                            if(finans[msg.sender].tokens >= tokenss)
                            {
                                products[pr_id].tokens[j] += tokenss;
                                products[pr_id].balance+=tokenss;
                                finans[msg.sender].tokens = finans[msg.sender].tokens - tokenss;
                            }
                        }
                    }
                    if(fin_found == false)
                    {
                        if(finans[msg.sender].tokens >= tokenss)
                        {
                            products[pr_id].fins.push(msg.sender);
                            products[pr_id].tokens.push(tokenss);
                            products[pr_id].number_of_fin += 1;
                            products[pr_id].balance += tokenss;
                            finans[msg.sender].tokens = finans[msg.sender].tokens - tokenss;
                        }
                        
                    }
                }
                
            }
        }
    }
    
    function show_applyer(uint256 project_id, uint256 applier_id) public view returns(string memory)
    {
        return frelancers[products[project_id].freelancers[applier_id]].name;
    }
    
    function show_contract(uint256 project_id) public view returns( string memory)
    {
        return products[project_id].descr;
    }
    
    function apply_for_job_freelancer(uint256 project_id, uint256 min_tokens) public
    {
        if(products[project_id].progress == Status.OPEN)
        {
            for(uint256 index = 0; index < frelancers_id; index += 1)
            {
                if(frelancers_adress[index] == msg.sender)
                {
                    bool freelancer_found=false;
                    for(uint256 j = 0 ; j < products[project_id].number_of_freelancers; j = j + 1)
                    {
                        if(products[project_id].freelancers[j]==msg.sender)
                        {
                            freelancer_found = true;
                            products[project_id].tokens_freelancer[j] = min_tokens;  
                            products[project_id].number_of_freelancers = products[project_id].number_of_freelancers + 1;
                        }
                    }
                    if(freelancer_found == false)
                    {
                        products[project_id].freelancers.push(msg.sender);
                        products[project_id].tokens_freelancer.push(min_tokens);
                        products[project_id].number_of_freelancers = products[project_id].number_of_freelancers + 1;
                    }
                }
            }
        }
    }
    
    function apply_for_job_evaluator(uint256 project_id) public
    {
        if(products[project_id].progress == Status.OPEN)
        {
            for(uint256 index = 0; index < evals_id; index += 1)
            {
                if(evals_adress[index] == msg.sender)
                {
                    if(products[project_id].evaluator == address(0))
                    {
                        products[project_id].evaluator = msg.sender;
                    }
                    else
                    {
                        revert("Already an evaluator is assigned to this project!");
                    }
                }
            }
        }
    }
    
    function choose_freelancer(uint256 project_id, uint256 freelancer_id) public
    {
        if(products[project_id].progress == Status.OPEN)
        {
            address freelancer_address_aux;
            uint256 freelancer_tokens_aux;
            for(uint256 index = 0; index < managers_id; index += 1)
            {
                if(managers_adress[index] == msg.sender)
                {
                    if(products[project_id].manager == msg.sender)
                    {
                        for(uint256 i = 0; i < products[project_id].number_of_freelancers; i = i + 1)
                        {
                            freelancer_address_aux = products[project_id].freelancers[i];
                            freelancer_tokens_aux = products[project_id].tokens_freelancer[i];
                            if(frelancers[freelancer_address_aux].id == freelancer_id)
                            {
                                if(products[project_id].tokens_used_for_dev + freelancer_tokens_aux <= products[project_id].DEV)
                                {
                                    products[project_id].freelancers_selected.push(freelancer_address_aux);
                                    products[project_id].tokens_for_selected_freelancers.push(freelancer_tokens_aux);
                                    products[project_id].number_of_selected_freelancers = products[project_id].number_of_selected_freelancers + 1;
                                    products[project_id].tokens_used_for_dev = products[project_id].tokens_used_for_dev + freelancer_tokens_aux;
                                }
                                else
                                {
                                    revert("Insuficient fonds!");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    function start_project(uint256 project_id) public
    {
        if(products[project_id].progress == Status.OPEN)
        {
            for(uint256 index = 0; index < managers_id; index += 1)
            {
                if(managers_adress[index] == msg.sender)
                {
                    if(products[project_id].manager == msg.sender)
                    {
                        if(products[project_id].tokens_used_for_dev == products[project_id].DEV)
                        {
                            products[project_id].progress = Status.IN_PROGRESS;
                        }
                    }
                }
            }
        }
    }
    
    function project_done(uint256 project_id) public
    {
        if(products[project_id].progress == Status.IN_PROGRESS)
        {
            for(uint256 i = 0; i < products[project_id].number_of_selected_freelancers; i = i + 1)
            {
                if(products[project_id].freelancers_selected[i] == msg.sender)
                {
                    products[project_id].progress = Status.IN_WAITING;
                }
            }
        }
    }
    
    function accept_project(uint256 project_id) public
    {
        if(products[project_id].progress == Status.IN_WAITING)
        {
            address freelancer_address_aux;
            uint256 freelancer_tokens_aux;
            for(uint256 index = 0; index < managers_id; index += 1)
            {
                if(managers_adress[index] == msg.sender)
                {
                    if(products[project_id].manager == msg.sender)
                    {
                        for(uint256 i = 0; i < products[project_id].number_of_selected_freelancers; i = i + 1)
                        {
                            freelancer_address_aux = products[project_id].freelancers[i];
                            freelancer_tokens_aux = products[project_id].tokens_freelancer[i];
                            
                            //frelancers[freelancer_address_aux].tokens += freelancer_tokens_aux;
                            tokenContract.transfer(freelancer_address_aux, freelancer_tokens_aux);
                            if(frelancers[freelancer_address_aux].reputation < 10)
                            {
                                frelancers[freelancer_address_aux].reputation += 1;
                            }
                            
                        }
                        if(products[project_id].arbitraj == false)
                        {
                            //managers[msg.sender].tokens += products[project_id].REV;
                            tokenContract.transfer(msg.sender, products[project_id].REV);
                            if(managers[msg.sender].reputation < 10)
                            {
                                managers[msg.sender].reputation += 1;
                            }
                        }
                        else
                        {
                            //evals[products[project_id].evaluator].tokens += products[project_id].REV;
                            tokenContract.transfer(products[project_id].evaluator, products[project_id].REV);
                        }
                        products[project_id].progress = Status.FINISHED;
                    }
                }
            }
        }
    }
    
    function reject_project(uint256 project_id) public
    {
        if(products[project_id].progress == Status.IN_WAITING)
        {
            for(uint256 index = 0; index < managers_id; index += 1)
            {
                if(managers_adress[index] == msg.sender)
                {
                    if(products[project_id].manager == msg.sender)
                    {
                        products[project_id].progress = Status.DISPUTE;
                    }
                }
            }
        }
    }
    
    function solve_dispute(uint256 project_id, bool result) public
    {
        if(products[project_id].progress == Status.DISPUTE)
        {
            if(products[project_id].evaluator == msg.sender)
            {
                products[project_id].arbitraj = true;
                address freelancer_address_aux;
                uint256 freelancer_tokens_aux;
                if(result == true) //freelanceri au dreptate
                {
                    for(uint256 i = 0; i < products[project_id].number_of_selected_freelancers; i = i + 1)
                    {
                        freelancer_address_aux = products[project_id].freelancers[i];
                        freelancer_tokens_aux = products[project_id].tokens_freelancer[i];
                        
                        //frelancers[freelancer_address_aux].tokens += freelancer_tokens_aux;
                        tokenContract.transfer(freelancer_address_aux, freelancer_tokens_aux);
                        if(frelancers[freelancer_address_aux].reputation < 10)
                        {
                            frelancers[freelancer_address_aux].reputation += 1;
                        }
                        
                    }
                    if(managers[products[project_id].manager].reputation > 0)
                    {
                        managers[products[project_id].manager].reputation -= 1;
                    }
                    //evals[products[project_id].evaluator].tokens += products[project_id].REV;
                    tokenContract.transfer(products[project_id].evaluator, products[project_id].REV);
                    products[project_id].progress = Status.FINISHED;
                }
                else
                {
                    for(uint256 i = 0; i < products[project_id].number_of_selected_freelancers; i = i + 1)
                    {
                        if(frelancers[freelancer_address_aux].reputation > 0)
                        {
                            frelancers[freelancer_address_aux].reputation -= 1;
                        }
                    }
                    
                    Product storage prod;
                    prod.descr=products[project_id].descr;
                    prod.number_of_fin=products[project_id].number_of_fin;
                    prod.manager=products[project_id].manager;
                    prod.DEV=products[project_id].DEV;
                    prod.REV=products[project_id].REV;
                    prod.id=products[project_id].id;
                    prod.balance=products[project_id].balance;
                    prod.progress = Status.OPEN;
                    prod.number_of_freelancers = 0;
                    prod.evaluator = address(0);
                    prod.number_of_selected_freelancers = 0;
                    prod.tokens_used_for_dev = 0;
                    prod.arbitraj = true;
                    products[project_id] = prod;
                    
                }
            }
        }
    }
    
}