<a name="readme-top"></a>
<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]]()
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT Name --> 
<h1 align="center">Design a round-robin arbiter to ensure that each request has an equal chance of being granted access to shared resources</h1>

<!-- Schmatic -->
## Schmatic
* In this design of the round-robin arbiter, two fixed priority arbiters are utilized to manage requests for a shared resource.
* The first arbiter, the unmasked arbiter, processes the original request.
  The second arbiter, the masked arbiter, processes the request ANDed with a mask.
* The masked arbiter takes priority over the unmasked one.
  If there is no masked request, the unmasked arbiter's result is used.
* However, if there is a masked request, the masked arbiter's result takes precedence. The mask determines which request has priority.
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/Schmatic_all.png)

* Enlarge the left half
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/Schmatic_left.png)

* Enlarge the right half
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/Schmatic_right.png)

<!-- Simulation -->
## Simulation
* The maskedRequest ensures that only requests with priority (i.e., those with a set mask bit) are processed by the masked arbiter.
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/request%5B0%5D%3D1_Simulation.png)

* The grant output checks whether the maskedRequest expression is 0.
  If it is, the unmasked arbiter's result is used.
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/request%5B0%5D%3D0_Simulation.png)
* If it is not, the masked arbiter's result is used.
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/request%5B0%5D%26request%5B1%5D%3D1_Simulation.png)

* The mask update ensures that requests are processed in a circular fashion, promoting statistical fairness and preventing starvation.
* When the N-th bit is granted, the subsequent bits above N must have priority in the next cycle.
  That is, the MSB:N+1 bits are set to 1, while the remaining bits are set to 0.
  For example, if the grant vector is 00001000, the mask will be 11110000 in the next cycle. 
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/request%5B2%5D%3D1%26request%5B1%5D%3D0_Simulation.png)
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/request%5B3%5D%3D1%26request%5B2%5D%3D0_Simulation.png)

* Requests in the MSB 4 bits are granted access, but if there are no requests in these bits, the unmasked arbiter's result is used.
  If no grant occurs during the cycle, the mask remains unchanged.
![image](https://github.com/trista-csee/Round_Robin_Arbiter/blob/main/request%5B3%5D%3D0_Simulation.png)

<!-- LICENSE -->
## License
Distributed under the MIT License. See `LICENSE` for more information.

<!-- LET'S GET SOCIAL -->
## Let's Get Social
* [LinkedIn](https://www.linkedin.com/in/hua-chen-wu-363252241/)
* [Github](https://github.com/trista-csee)

<!-- CONTACT -->
## Contact
吳華楨 Trista Wu - trista.cs11@nycu.edu.tw

Project Link: [https://github.com/trista-csee/Round_Robin_Arbiter](https://github.com/trista-csee/Round_Robin_Arbiter)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/badge/contributors-1-orange.svg?style=flat-square
[license-shield]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square
[license-url]: https://choosealicense.com/licenses/mit
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/hua-chen-wu-363252241/
[product-screenshot]: ./images/projects/portfolio.jpg

