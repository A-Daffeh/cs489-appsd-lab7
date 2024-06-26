package com.cs489.Lab7.repository;

import com.cs489.Lab7.model.Address;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AddressRepository extends JpaRepository<Address, Long> {
    @Query("SELECT a FROM Address a JOIN FETCH a.patient ORDER BY a.city")
    List<Address> findAllWithPatientsOrderByCity();
}
